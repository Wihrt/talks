# Démo Terragrunt

La même infrastructure que la démo Terramate, modélisée avec Terragrunt, pour comparer côte à côte : un socle (réseau, Kubernetes), une zone partagée (Paris) et un espace d'équipe (stockage, base) qui consomme le `subnet_id` de la zone. Tout tourne hors ligne : OpenTofu avec des `terraform_data` et un backend local, aucun compte cloud.

Testé avec Terragrunt 1.1.6 et OpenTofu 1.10. Il faut les deux dans le `PATH`, par exemple :

```sh
mise use -g terragrunt@1.1.6 opentofu@1.10
```

## Préparer

```sh
./prepare.sh /tmp/terragrunt-demo   # copie la démo dans un repo git neuf, commit initial sur main, tag v1
cd /tmp/terragrunt-demo
export ETAT_DEMO=$PWD/.state        # voir « Différences » : l'état doit avoir un chemin absolu
cd live                             # on travaille dans live/ : le catalogue n'est pas une infra à déployer
```

`get_repo_root()` et `--filter-affected` s'appuient sur git : la démo vit dans son propre repo.

## Arborescence

```
root.hcl                      inclus par toutes les unités : backend local, generate versions, inputs communs
commun.hcl                    valeurs partagées (organisation, région...), lues par root.hcl
modules/                      modules OpenTofu : reseau, cluster, zone, bucket, base-de-donnees
live/socle/reseau/            unité écrite à la main
live/socle/kubernetes/        unité écrite à la main, dependency "reseau", module local modules/cluster
live/socle/zones/paris/       la zone partagée : expose la sortie subnet_id
live/equipes/paiement/        ce qu'écrit une équipe : un terragrunt.stack.hcl (unit + values)
catalogue/units/              unités du catalogue : stockage, base (lisent `values`, dependency sur la zone)
```

## Scénario (~11 min)

### 1. Les unités et l'ordre (~1 min)

```sh
terragrunt list --dag -l --dependencies   # reseau avant kubernetes et zone. Les unités de l'équipe naissent au generate
terragrunt dag graph                      # le même graphe, au format DOT
cat socle/kubernetes/terragrunt.hcl       # dependency "reseau" : l'ordre ET la sortie vpc_id
```

### 2. La génération de code (~3 min)

```sh
cat ../root.hcl                           # remote_state + generate "versions" + inputs : écrits une fois
cat ../commun.hcl
terragrunt stack generate                 # les unités de paiement apparaissent dans .terragrunt-stack/ (ignoré par git)
terragrunt list --dag -l --dependencies   # stockage après kubernetes et zone-paris, base après zone-paris
cat equipes/paiement/.terragrunt-stack/stockage/terragrunt.values.hcl
terragrunt run --all -- init              # génère le backend et versions.tf dans .terragrunt-cache de chaque unité
cat socle/kubernetes/.terragrunt-cache/*/*/_terragrunt_backend.tf
cat socle/kubernetes/.terragrunt-cache/*/*/_terragrunt_versions.tf
```

Rien à commiter : les fichiers générés vivent dans `.terragrunt-cache`, hors git.

### 3. L'orchestration (~2 min)

```sh
terragrunt run --all --non-interactive --parallelism 4 -- apply -auto-approve   # l'ordre est respecté, le reste en parallèle
terragrunt run --all --non-interactive -- apply -auto-approve                   # idempotent : « No changes »
```

Sans `--non-interactive` (ou `TG_NON_INTERACTIVE=1`), `run --all apply` demande confirmation même avec `-auto-approve`. Le `subnet_id` du stockage est la vraie sortie de la zone (`subnet-paris`), lue dans son état.

### 4. La détection de changements (~2 min)

```sh
git switch -c montee-k8s
sed -i 's/"1.34"/"1.35"/' socle/kubernetes/terragrunt.hcl
git commit -am "Kubernetes 1.35"
terragrunt list --filter-affected                              # une seule unité
terragrunt run --all --filter-affected -- plan                 # 1.34 -> 1.35

git switch main && git switch -c module
echo '# modif' >> ../modules/cluster/main.tf && git commit -am "Module"
terragrunt list --filter-affected                              # l'unité qui appelle le module (via terraform.source)
```

`--filter-affected` équivaut à `--filter '[main...HEAD]'`.

### 5. Self-service : une nouvelle équipe (~3 min)

```sh
git switch main && git switch -c equipe-catalogue
cat equipes/paiement/terragrunt.stack.hcl                      # ce qu'écrit un dev : des unit + values
cat ../catalogue/units/stockage/terragrunt.hcl                 # ce qu'écrit la plateforme : la zone vient de values.zone
mkdir equipes/catalogue
sed -e 's/paiement/catalogue/' -e '/^unit "base"/,$d' \
    equipes/paiement/terragrunt.stack.hcl > equipes/catalogue/terragrunt.stack.hcl   # sans base : on supprime le bloc
terragrunt stack generate                                      # les unités de l'équipe apparaissent
cat equipes/catalogue/.terragrunt-stack/stockage/terragrunt.values.hcl
git add -A && git commit -m "Équipe catalogue"
terragrunt list --filter-affected                              # seulement la nouvelle équipe
terragrunt run --all --non-interactive --filter-affected -- apply -auto-approve
```

Pas de formulaire : l'équivalent de `terramate ui` n'existe pas ici. Le plus proche est `scaffold`, qui génère une unité depuis un module du catalogue :

```sh
mkdir -p equipes/catalogue/scaffold && cd equipes/catalogue/scaffold
terragrunt scaffold "git::file://$(git rev-parse --show-toplevel)//modules/bucket?ref=v1"
cat terragrunt.hcl                                             # les variables du module en TODO, avec leurs description et type
cd ../../..
```

La source doit être une URL git avec `?ref=` (d'où le tag `v1` posé par `prepare.sh`). Aucune question n'est posée : les valeurs sont à remplir dans le fichier.

## Plan B

Si le live casse : chaque étape a sa sortie attendue dans les slides. Garder un terminal avec la démo déjà jouée jusqu'à l'étape 5.

## Différences avec Terramate

Uniquement ce qui a été observé en testant cette démo (Terragrunt 1.1.6).

- **Ordre et échange de valeurs** : un seul mécanisme, `dependency` (ordre + `outputs`). Il faut `mock_outputs` pour que `init`, `plan` et `validate` passent avant que la dépendance existe. Terramate sépare `after` (ordre) et les exports de bundle (valeurs).
- **Code généré** : `generate` (backend, versions) écrit dans `.terragrunt-cache`, rien n'est commité ni vérifié par git. Terramate commite les fichiers générés et refuse `run` s'ils sont périmés.
- **Génération de stacks** : `terragrunt stack generate` écrit `.terragrunt-stack/` (dans `.gitignore`). `run --all` régénère les stacks tout seul.
- **Pas de lien typé entre bundles** : la zone est désignée par une chaîne (`values.zone`) qui compose un chemin. Rien ne vérifie qu'elle existe avant le `run`.
- **Découverte** : lancé à la racine, Terragrunt traite `catalogue/units/*` comme des unités. D'où le travail dans `live/`, et les `try(values.x, ...)` du catalogue : sans eux, `--filter-affected` échoue sur ces fichiers, qui lisent `values` hors d'un stack.
- **`--filter-affected`** : les unités sont exécutées dans un worktree git temporaire (`/tmp/terragrunt-worktree-HEAD-*`). Un état local relatif au repo y est vide : le plan montrait « create » et `vpc-mock`. D'où `ETAT_DEMO`, un chemin absolu. Avec un backend distant, le problème n'existe pas.
- **Changement de module** : détecté. `modules/cluster` modifié, la liste contient `socle/kubernetes` (la source de l'unité). Le plan dit « No changes » car seul un commentaire change.
- **Dépendants** : `--filter-affected` ne remonte pas les unités qui dépendent d'une unité changée.
- **Self-service** : pas de formulaire ni de `prompt`. `scaffold` produit un `terragrunt.hcl` à remplir. Une source locale (chemin simple ou `file://` sans `?ref`) a échoué à mon test (« destination exists and is not a symlink »), le `git::file://...//modules/x?ref=v1` fonctionne, avec deux avertissements « Failed to parse url » sans conséquence.
- **« Bundle »** : il n'y a pas d'équivalent à un bundle versionné avec entrées typées ; l'équipe écrit ses blocs `unit` + `values`, et supprime le bloc `base` si elle n'en veut pas. Les `values` ne sont pas validés.
- **Non reproduit ici** : les `tm_dynamic` (services du cluster), les fiches `catalog-info.yaml`, les scripts nommés, `--reverse`.
