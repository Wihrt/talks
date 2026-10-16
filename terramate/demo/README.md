# Démo Terramate

Un repo Terramate autonome : un socle (réseau, Kubernetes) et des espaces d'équipe créés par un bundle Catalyst. Tout tourne hors ligne : OpenTofu avec des `terraform_data` et un backend local, aucun compte cloud.

Testé avec Terramate 0.17.3 et OpenTofu 1.10. Il faut les deux dans le `PATH`, par exemple :

```sh
mise use -g terramate@0.17.3 opentofu@1.10
```

## Préparer

```sh
./prepare.sh /tmp/terramate-demo   # copie la démo dans un repo git neuf, commit initial sur main
cd /tmp/terramate-demo
```

Terramate prend la racine git comme racine du projet : la démo vit dans son propre repo.

## Arborescence

```
terramate.tm.hcl            config du projet (branche par défaut, env, expérimentations)
globals.tm.hcl              globals hérités par toutes les stacks + import des générateurs
imports/                    generate_hcl : backend et locals de chaque stack
scripts.tm.hcl              workflows nommés : previsualisation, deploiement
modules/cluster/            module local, utilisé par la stack kubernetes
stacks/socle/reseau/        stack écrite à la main
stacks/socle/kubernetes/    stack écrite à la main, after = ["tag:reseau"]
catalogue/composants/       Catalyst : briques (bucket, base PostgreSQL)
catalogue/bundles/          Catalyst : « espace d'équipe », assemble les composants en stacks
equipes/paiement.tm.yml     ce qu'écrit une équipe : une instance de bundle, en YAML
```

## Scénario (~10 min)

### 1. Les stacks et l'ordre (~1 min)

```sh
terramate list
terramate list --run-order        # reseau avant kubernetes (after). Pas encore d'équipe : leurs stacks naissent au generate
cat stacks/socle/kubernetes/stack.tm.hcl
```

### 2. La génération de code (~2 min)

```sh
terramate generate                # backend + locals dans chaque stack, et les stacks des bundles
terramate list --run-order        # les stacks de paiement sont apparues, à leur place dans l'ordre
cat stacks/socle/kubernetes/_terramate_backend.tf
terramate run -- tofu init        # refusé : fichiers non commités. Les garde-fous.
git add -A && git commit -m "Code généré"
```

### 3. L'orchestration (~2 min)

```sh
terramate run -- tofu init
terramate run --parallel 4 -- tofu apply -auto-approve   # l'ordre est respecté, le reste en parallèle
terramate script run deploiement                         # le même workflow, déclaré une fois
terramate list --tags socle
terramate run --reverse --dry-run -- tofu destroy        # l'ordre inverse pour détruire
```

### 4. La détection de changements (~2 min)

```sh
git switch -c montee-k8s
sed -i 's/"1.34"/"1.35"/' stacks/socle/kubernetes/main.tf
git commit -am "Kubernetes 1.35"
terramate list --changed --why                           # une seule stack
terramate run --changed -- tofu plan

git switch main && git switch -c module
echo '# modif' >> modules/cluster/main.tf && git commit -am "Module"
terramate list --changed --why                           # la stack qui appelle le module
```

### 5. Catalyst : une nouvelle équipe en self-service (~3 min)

```sh
git switch main && git switch -c equipe-catalogue
cat equipes/paiement.tm.yml                              # ce qu'écrit un dev : du YAML
cat catalogue/bundles/espace-equipe/v1/bundle.tm.hcl     # ce qu'écrit la plateforme
terramate ui                                             # formulaire interactif → equipes/catalogue.tm.yml
#   sans TUI : sed 's/paiement/catalogue/g; s/base: true/base: false/; /taille_base/d' \
#              equipes/paiement.tm.yml > equipes/catalogue.tm.yml
terramate generate                                       # les stacks de l'équipe apparaissent
git add -A && git commit -m "Équipe catalogue"
terramate list --changed                                 # seulement les nouvelles stacks
terramate run --changed -- tofu init
terramate run --changed -- tofu apply -auto-approve
```

## Plan B

Si le live casse : chaque étape a sa sortie attendue dans les slides. Garder un terminal avec la démo déjà jouée jusqu'à l'étape 5.

## Pièges connus

- Les blocs `script` sont encore derrière `experiments = ["scripts"]`.
- 0.17.3 : quand un bundle crée une stack, l'ordre des tags lu au premier `generate` peut différer du suivant. Un générateur qui écrit `terramate.stack.tags` produit alors un fichier « périmé » et `terramate run` refuse de tourner. D'où l'absence des tags dans `_terramate_locals.tf`.
