# Démo Atmos

La même infrastructure que la démo Terramate, modélisée avec Atmos (Cloud Posse), pour comparer côte à côte : un socle (réseau, Kubernetes), une zone partagée (Paris) et un espace d'équipe (stockage, base) qui consomme le `subnet_id` de la zone. Tout tourne hors ligne : OpenTofu avec des `terraform_data` et un backend local, aucun compte cloud.

Testé avec Atmos 1.232.0 et OpenTofu 1.10. Il faut les deux dans le `PATH`, par exemple :

```sh
mise use -g atmos@1.232.0 opentofu@1.10
```

## Préparer

```sh
./prepare.sh /tmp/atmos-demo        # copie la démo dans un repo git neuf, commit initial sur main
cd /tmp/atmos-demo
export ETAT_DEMO=$PWD/.state        # voir « Différences » : l'état doit avoir un chemin absolu
export ATMOS_TELEMETRY_DISABLED=true
```

`atmos describe affected` et `--affected` comparent deux refs git : la démo vit dans son propre repo.

## Arborescence

```
atmos.yaml                    config du projet : tofu, backend généré, nom des stacks, workflows, gabarit scaffold
components/terraform/         les modules racine : reseau, cluster, zone, bucket, base-de-donnees
modules/cluster/              module local, appelé par components/terraform/cluster
stacks/deploy/prod.yaml       LA stack « prod » : un fichier qui importe tout le reste
stacks/mixins/commun.yaml     vars communes, backend local par composant, fichier généré (atmos_versions.tf)
stacks/catalog/               composants du socle (reseau, kubernetes) et briques d'équipe (abstraites)
stacks/plateforme/zone-paris.yaml   la zone partagée
stacks/equipes/paiement.yaml  ce qu'écrit une équipe : du YAML (importé par prod.yaml via equipes/*)
workflows/deploiement.yaml    workflows nommés : previsualisation, deploiement
scaffolds/equipe/             gabarit « nouvelle équipe » (atmos scaffold)
```

## Scénario (~11 min)

### 1. Les composants et l'ordre (~1 min)

```sh
atmos list stacks
atmos list dependencies                                          # arbre complet, dans les deux sens
atmos list dependencies paiement-stockage --direction forward    # kubernetes et zone-paris, puis reseau
atmos describe dependents reseau -s prod --query '.[].component' # qui dépend de reseau (direct)
cat stacks/catalog/kubernetes.yaml                               # dependencies.components : l'ordre ; !terraform.state : la valeur
```

### 2. La génération de code (~3 min)

```sh
cat atmos.yaml
cat stacks/mixins/commun.yaml                                    # backend local, calculé par composant, et un fichier généré
atmos describe component reseau -s prod                          # le résultat de l'héritage, avec la provenance de chaque ligne
atmos terraform generate backend reseau -s prod
cat components/terraform/reseau/backend.tf.json                  # le backend, écrit dans le dossier du composant
atmos terraform generate files reseau -s prod
cat components/terraform/reseau/atmos_versions.tf                # le bloc « generate » de commun.yaml
git status --short                                               # rien : les fichiers générés sont dans .gitignore
```

### 3. L'orchestration (~2 min)

```sh
atmos terraform plan --all -s prod                               # échoue : l'état de reseau n'existe pas encore (voir « Différences »)
atmos terraform apply --all -s prod -auto-approve --max-concurrency 4
atmos terraform apply --all -s prod -auto-approve                # idempotent : « No changes »
atmos workflow deploiement -f deploiement                        # le même apply, déclaré une fois
atmos terraform destroy --all -s prod --dry-run                  # l'ordre inverse pour détruire
```

`--all` ordonne par `dependencies.components` ; `--max-concurrency` borne le parallélisme (1 par défaut).

### 4. La détection de changements (~2 min)

```sh
git switch -c montee-k8s
sed -i 's/"1.34"/"1.35"/' stacks/catalog/kubernetes.yaml
git commit -am "Kubernetes 1.35"
atmos describe affected --base main --format yaml                # une seule stack/composant : kubernetes
atmos terraform plan --affected --ref refs/heads/main -s prod    # 1.34 -> 1.35

git switch main && git switch -c module
echo '# modif' >> modules/cluster/main.tf && git commit -am "Module"
atmos describe affected --base main --format yaml                # kubernetes, grâce à dependencies.folders
atmos describe affected --base main --include-dependents --format yaml   # + paiement-stockage, en dépendant
```

### 5. Self-service : une nouvelle équipe (~3 min)

```sh
git switch main && git switch -c equipe-catalogue
cat stacks/equipes/paiement.yaml                                 # ce qu'écrit un dev : du YAML
cat stacks/catalog/equipe.yaml                                   # ce qu'écrit la plateforme : les briques abstraites
cat scaffolds/equipe/scaffold.yaml                               # les questions posées à l'équipe
atmos scaffold list
atmos scaffold generate equipe . --force --defaults \
  --set equipe=catalogue --set base=true --set taille_base=L     # sans --set : formulaire interactif
cat stacks/equipes/catalogue.yaml                                # le fichier créé, importé tout seul par prod.yaml
atmos list dependencies catalogue-stockage -s prod --direction forward
git add -A && git commit -m "Équipe catalogue"
atmos describe affected --base main --format yaml                # seulement les nouveaux composants
atmos terraform apply --affected --ref refs/heads/main -s prod -auto-approve
```

`--force` est requis parce que la cible (`.`) n'est pas vide ; les fichiers existants ne sont pas touchés, seul le nouveau est écrit (plus `.atmos/scaffold.yaml`, l'enregistrement des réponses).

## Plan B

Si le live casse : chaque étape a sa sortie attendue dans les slides. Garder un terminal avec la démo déjà jouée jusqu'à l'étape 5.

## Différences avec Terramate

Uniquement ce qui a été observé en testant cette démo (Atmos 1.232.0).

- **Ordre et échange de valeurs** : deux mécanismes distincts, comme Terramate : `dependencies.components` (ordre) et `!terraform.state` (valeur, lue dans l'état). Mais rien ne les relie : il faut écrire les deux.
- **Pas de valeur factice** : `!terraform.state` échoue tant que l'amont n'est pas déployé (« terraform state not provisioned for component reseau »). `plan --all` et `terraform generate backend kubernetes` échouent avant le premier `apply` (d'où `generate backend reseau` à l'étape 2). `describe component` et `describe dependents` affichent `(computed)` à la place. Terramate calcule l'export du bundle au `generate`, sans état.
- **Workspaces** : par défaut Atmos crée un workspace par composant, et le `path` du backend local est ignoré (l'état atterrit dans `terraform.tfstate.d/<workspace>/` du composant, et `!terraform.state` ne le trouve pas). `workspaces_enabled: false` dans `atmos.yaml` règle les deux.
- **Une stack = un fichier** : `prod` est tout ce que Atmos appelle stack ; les composants sont des « instances » dans ce fichier. Il n'y a pas de dossier par stack à la Terramate : une nouvelle équipe est un fichier importé par glob (`equipes/*`), pas des dossiers.
- **Code généré** : `backend.tf.json`, `atmos_versions.tf` (bloc `generate`, marqué expérimental dans la doc) et les varfiles sont écrits dans `components/terraform/<composant>/`, partagés entre toutes les instances d'un même dossier. Ignorés par git : pas de garde-fou « fichiers non commités », on ne les relit pas en revue.
- **Parallélisme** : `--max-concurrency` (1 par défaut) ; Terramate : `--parallel`. `plan` écrit un `<stack>-<composant>.planfile` dans le dossier du composant (ignoré par git).
- **Ordre inverse** : `atmos terraform destroy --all --dry-run` liste l'ordre inverse (équipe, kubernetes, zone, réseau).
- **Workflows** : `workflows/deploiement.yaml` est une liste de commandes Atmos ; l'ordre vient de `--all`, pas du workflow. Pas de `script run` ni de tags.
- **Chemin d'état et `--affected`** : Atmos compare dans un répertoire git temporaire. Avec un chemin relatif, `describe affected` annonçait aussi `paiement-base` et `paiement-stockage` (`stack.vars`, valeurs `(computed)`), et `plan --affected` échouait sur l'état de `zone-paris`. D'où `ETAT_DEMO`, un chemin absolu. Même piège que Terragrunt ; avec un backend distant, il n'existe pas.
- **Changement de composant** : détecté (`affected: component`) si le dossier `components/terraform/<x>` change. Pour les composants d'équipe qui héritent d'une brique abstraite, `metadata.component` doit être écrit sur l'instance, pas seulement sur l'abstraite : sinon `describe affected` cherche `components/terraform/paiement-base` et rate le changement de `base-de-donnees` (testé sur 4 composants modifiés).
- **Changement de module** : `modules/cluster` est hors du dossier du composant. Sans rien déclarer, `describe affected` renvoie `[]` (testé). Avec `dependencies.folders: [modules/cluster]` sur `kubernetes`, le composant est détecté (`affected: folder`). Terramate détecte le module sans déclaration, via les `source`.
- **Dépendants** : `describe affected` ne les inclut pas par défaut ; `--include-dependents` ajoute `paiement-stockage` sous `kubernetes`.
- **Nouvelle équipe** : `describe affected` l'annonce `affected: stack.metadata` (deux composants), et `apply --affected` ne déploie que ceux-là.
- **Self-service** : `atmos scaffold` (expérimental) lit un `scaffold.yaml` (champs `input`, `confirm`, `select`, `when:` CEL, validation par regex) et rend un fichier à partir d'un gabarit. C'est le plus proche de `terramate ui`. Ici le gabarit produit `stacks/equipes/<nom>.yaml`. Les entrées ne sont pas typées par rapport à d'autres bundles (pas de `bundle("zone")`) : `zone` est une chaîne, la zone inexistante n'échoue qu'au calcul de `dependencies`. Pas de versionnage du catalogue.
- **Abstraits** : Atmos évalue aussi les composants abstraits (`metadata.type: abstract`) ; sans `settings.zone` par défaut dans la brique, `apply --all` échouait (« zone-<no value> »).
- **`atmos init`** : sert à créer un projet entier depuis un exemple, pas à ajouter une équipe.
- **Installation** : un binaire unique, comme Terramate.
- **Non reproduit ici** : les `tm_dynamic` (services du cluster), les fiches `catalog-info.yaml`, les environnements dev/prod, `scaffold` en mode formulaire (pas de TTY dans mes tests).
