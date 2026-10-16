# Démo Terraspace

Les mêmes infrastructures que la démo Terramate, pour comparer côte à côte : un socle (réseau, Kubernetes), une zone « paris » et un espace d'équipe (stockage + base) qui consomme le `subnet_id` de la zone. Tout tourne hors ligne : OpenTofu avec des `terraform_data` et un backend local, aucun plugin cloud, aucun compte.

Testé avec Terraspace 2.2.20, Ruby 3.3.12 et OpenTofu 1.10.10 (Terraspace trouve `tofu` seul, sans `TS_TERRAFORM_BIN`).

## Installer

```sh
mise install                     # ruby 3.3 + opentofu 1.10 (mise.toml)
gem install terraspace -v '~> 2.2.0'
```

`gem install` compile une extension C++ (eventmachine) : il faut `gcc`, `g++` et `make`. Sans compilateur sur la machine, l'installation échoue (testé sans gcc : « The compiler failed to generate an executable file »).

## Préparer

```sh
./prepare.sh /tmp/terraspace-demo   # copie la démo dans un repo git neuf, commit initial sur main
cd /tmp/terraspace-demo
export TF_INPUT=0
```

Terraspace n'a pas besoin de git : le repo sert seulement à rejouer les commits comme avec Terramate. Pas de `terraspace new project` ici : la démo est un projet déjà écrit (`--plugin none` existe, mais l'aide ne liste que `aws, google`).

## Arborescence

```
mise.toml                     ruby + opentofu
Gemfile                       terraspace ~> 2.2
config/app.rb                 config du projet (concurrence de « all »)
config/terraform/             copié dans CHAQUE stack, avec ERB : backend, locals, version
app/modules/                  modules locaux : cluster, bucket, base_de_donnees
app/stacks/reseau/            stack écrite à la main
app/stacks/kubernetes/        output("reseau.vpc_nom") dans tfvars/base.tfvars, services en boucle ERB
app/stacks/zone/              la zone paris, expose subnet_id
app/stacks/paiement_stockage/ output("zone.subnet_id") + depends_on("kubernetes")
app/stacks/paiement_base/     output("zone.subnet_id"), tfvars/prod.tfvars surcharge la taille
```

Il n'y a ni catalogue, ni bundle, ni YAML d'équipe : une équipe = deux dossiers dans `app/stacks/`.

## Scénario (~10 min)

### 1. Les stacks et l'ordre (~1 min)

```sh
terraspace list
terraspace all graph --format text    # l'arbre des dépendances (le format png demande Graphviz)
cat app/stacks/paiement_stockage/tfvars/base.tfvars
```

L'ordre n'est pas déclaré dans un fichier de stack : il est déduit des appels `output("stack.sortie")` et `depends_on("stack")` écrits dans les `tfvars`. Terraspace compile les tfvars de toutes les stacks pour construire le graphe, d'où `mock:` pour les sorties pas encore déployées.

### 2. La génération de code (~3 min)

```sh
terraspace all plan -y                # compile toutes les stacks dans .terraspace-cache/dev/stacks/ (sorties amont : mock)
cat config/terraform/backend.tf       # le gabarit : expansion(':ENV/:MOD_NAME')
cat .terraspace-cache/dev/stacks/kubernetes/backend.tf
cat .terraspace-cache/dev/stacks/kubernetes/locals.tf
cat app/stacks/kubernetes/main.tf     # une boucle ERB : un bloc par service
cat .terraspace-cache/dev/stacks/kubernetes/main.tf
ls .terraspace-cache/dev/stacks/kubernetes/*.tfvars   # 1-base puis 2-dev : les couches
TS_ENV=prod terraspace all plan -y
cat .terraspace-cache/prod/stacks/kubernetes/*.tfvars # prod : pas de dev.tfvars, version_k8s = 1.34
```

Ne pas lancer `terraspace build kubernetes` avant un premier déploiement : testé, `output("reseau.vpc_nom")` échoue (« Backend initialization required », `tofu state pull` sur une stack jamais initialisée). `all plan` passe grâce au `mock:`.

Le code généré vit dans `.terraspace-cache/` (ignoré par git, jamais commité) : pas de garde-fou « fichiers non commités », on ne revoit pas le généré en revue.

### 3. L'orchestration (~2 min)

```sh
terraspace all up -y                  # lots : reseau | zone, kubernetes | paiement_base, paiement_stockage
terraspace all up -y                  # idempotent : « No changes » partout
terraspace all down                   # l'ordre inverse (répondre N pour juste voir le plan)
terraspace all up --stacks paiement_base    # une stack et ses dépendances (reseau, zone), pas le reste
```

### 4. La détection de changements (~2 min)

```sh
git switch -c montee-k8s
sed -i 's/"1.35"/"1.36"/' app/stacks/kubernetes/tfvars/dev.tfvars
git commit -am "Kubernetes 1.36"
terraspace all plan -y                # planifie les 5 stacks ; seule kubernetes a des changements
```

Terraspace n'a aucune détection de changements fondée sur git : pas d'équivalent de `terramate list --changed`. `all plan` lance un `plan` sur chaque stack et c'est Terraform qui dit « No changes ». Aucune option `--changed`, aucun lien module vers stacks calculé hors de `plan`.

### 5. Self-service : une nouvelle équipe (~2 min)

```sh
git switch main && git switch -c equipe-catalogue
terraspace new stack catalogue_demo --plugin none   # le générateur : main.tf, variables.tf, outputs.tf vides
rm -r app/stacks/catalogue_demo
cp -r app/stacks/paiement_stockage app/stacks/catalogue_stockage    # en pratique : on copie une stack existante
sed -i 's/paiement/catalogue/' app/stacks/catalogue_stockage/main.tf
terraspace all graph --format text
terraspace all up -y
```

Les générateurs de Terraspace (`new stack`, `new module`, `new hook`, `new helper`…) produisent des squelettes vides. Les gabarits sont ceux de la gem ; pas de dossier de gabarits dans le projet (lu dans le code de la gem 2.2.20). Pas de formulaire, pas de type `bundle(...)`, pas de validation des entrées.

## Différences avec Terramate

Uniquement ce qui a été observé dans les tests ci-dessus.

- Ordre : déduit des tfvars (`output()`, `depends_on()`), pas de `after`/`before` ni de tags. `terraspace all up` affiche les lots avant de les lancer.
- `output()` lit l'état de la stack source (`tofu state pull`) : tant que l'amont n'est pas déployé, `mock:` fournit la valeur pour `all plan` ; `terraspace build <stack>` seul échoue (voir étape 2). Terramate passe par un export de bundle calculé au `generate`, sans état.
- Génération : à la compilation, dans `.terraspace-cache/` ; ERB (Ruby) au lieu de HCL (`tm_dynamic`, `generate_hcl`). Tout fichier de `config/terraform/` est copié dans toutes les stacks, pas de `stack_filter` : pour cibler une stack, il faut `app/stacks/<nom>/`.
- Environnements : couches de tfvars (`base`, `dev`, `prod`) choisies par `TS_ENV`, `dev` par défaut ; la stack est compilée dans `.terraspace-cache/<env>/`.
- Parallélisme : `all up` lance les stacks d'un même lot en parallèle (`config.all.concurrency`), lot après lot.
- Sélection : `all up --stacks <nom>` inclut les dépendances ; pas d'équivalent de `--changed` (aucune occurrence dans `cli.rb`), ni de tags.
- Pas de catalogue/bundle/UI : une équipe est un copier-coller de dossiers.
- Installation : une gem Ruby avec une extension native (compilateur requis) au lieu d'un binaire unique.
