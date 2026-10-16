---
theme: default
routerMode: hash
title: "Terramate : orchestrer, générer, industrialiser son Terraform"
info: |
  Jusqu'où peut-on aller avec Terramate quand Terraform passe à l'échelle : orchestrer, générer, donner en self-service. Avec une démo.
author: Arnaud Hatzenbuhler
colorSchema: auto
transition: fade
mdc: true
fonts:
  sans: Archivo
  serif: Literata
  mono: JetBrains Mono
layout: cover
---

<p class="eyebrow">Talk technique · démo</p>
<h1>Terramate</h1>
<h2>Orchestrer, générer, industrialiser son Terraform</h2>
<p class="muted" style="margin-top:2rem">Arnaud Hatzenbuhler</p>

<!--
**⏱ Ouverture : ~3 min**

Repères : titre · talk technique, du code et une démo · Terraform et OpenTofu, même combat : je dis « Terraform » pour les deux
-->

---

<div class="grid grid-cols-2 gap-12" style="height:100%;align-items:center">
<div style="display:grid;justify-items:center;gap:1rem">
<img src="./arnaud.jpg" alt="Arnaud Hatzenbuhler" style="width:15rem;height:15rem;object-fit:cover;border-radius:50%;border:5px solid var(--accent)">
<h1 style="margin:0;font-size:2.4rem">Arnaud Hatzenbuhler</h1>
<p style="margin:0;color:var(--accent);font-family:Archivo,sans-serif;font-weight:600;font-size:1.2rem">Platform Engineer / Expert DevOps</p>
<p class="eyebrow" style="margin:0">OBS</p>
</div>
<div style="display:grid;justify-items:center;gap:1rem">
<div style="background:#fff;color:#1f1830;border:1px solid var(--line);border-radius:12px;padding:1.2rem"><svg viewBox="0 0 33 33" role="img" aria-label="QR code LinkedIn" style="width:14rem;height:14rem;display:block"><path stroke="currentColor" d="M0 0.5h7m2 0h1m3 0h2m1 0h1m1 0h3m2 0h1m2 0h7m-33 1h1m5 0h1m3 0h9m2 0h2m1 0h1m1 0h1m5 0h1m-33 1h1m1 0h3m1 0h1m1 0h4m1 0h1m1 0h1m2 0h4m4 0h1m1 0h3m1 0h1m-33 1h1m1 0h3m1 0h1m1 0h1m1 0h3m1 0h4m1 0h1m2 0h3m1 0h1m1 0h3m1 0h1m-33 1h1m1 0h3m1 0h1m1 0h1m2 0h1m3 0h1m2 0h3m2 0h1m2 0h1m1 0h3m1 0h1m-33 1h1m5 0h1m1 0h1m3 0h2m1 0h4m2 0h1m2 0h1m1 0h1m5 0h1m-33 1h7m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h7m-25 1h1m1 0h3m2 0h1m3 0h1m1 0h2m1 0h1m-25 1h1m1 0h5m3 0h1m1 0h4m1 0h1m4 0h3m1 0h5m-27 1h2m1 0h1m3 0h1m4 0h1m1 0h2m1 0h1m1 0h1m2 0h2m1 0h2m1 0h1m-29 1h4m2 0h2m3 0h4m2 0h2m1 0h1m1 0h1m1 0h1m1 0h2m-31 1h5m1 0h2m1 0h2m2 0h1m1 0h1m1 0h6m2 0h1m1 0h4m-31 1h1m4 0h2m1 0h1m7 0h4m1 0h4m2 0h2m1 0h1m-32 1h5m2 0h2m1 0h2m2 0h4m1 0h1m2 0h2m2 0h1m2 0h4m-33 1h1m1 0h1m3 0h2m2 0h1m2 0h1m3 0h1m4 0h1m2 0h3m2 0h2m-32 1h3m1 0h1m4 0h3m1 0h2m1 0h1m2 0h3m3 0h2m3 0h1m-29 1h2m1 0h4m3 0h1m1 0h1m2 0h1m4 0h1m1 0h2m1 0h2m3 0h1m-32 1h1m3 0h1m1 0h1m2 0h1m2 0h2m3 0h4m1 0h5m1 0h4m-32 1h2m2 0h2m3 0h1m1 0h1m1 0h2m2 0h1m1 0h1m4 0h1m1 0h2m1 0h2m-32 1h2m1 0h2m3 0h1m2 0h2m3 0h1m4 0h1m1 0h1m1 0h1m1 0h5m-32 1h1m4 0h2m2 0h2m1 0h1m4 0h4m4 0h1m2 0h2m-30 1h1m1 0h2m6 0h4m1 0h1m1 0h1m1 0h1m3 0h1m2 0h1m2 0h1m2 0h1m-33 1h1m1 0h1m3 0h1m2 0h2m4 0h1m4 0h1m3 0h2m3 0h3m-32 1h1m4 0h1m1 0h4m2 0h1m1 0h1m4 0h8m1 0h3m-32 1h1m1 0h2m2 0h2m6 0h2m1 0h2m3 0h1m1 0h5m3 0h1m-25 1h2m1 0h1m4 0h1m1 0h3m2 0h2m3 0h1m1 0h1m1 0h1m-33 1h7m4 0h2m1 0h5m2 0h4m1 0h1m1 0h1m1 0h2m-32 1h1m5 0h1m1 0h5m2 0h1m4 0h5m3 0h3m1 0h1m-33 1h1m1 0h3m1 0h1m1 0h2m1 0h2m4 0h2m1 0h1m3 0h6m1 0h2m-33 1h1m1 0h3m1 0h1m1 0h3m1 0h4m1 0h1m1 0h1m1 0h3m1 0h1m2 0h1m2 0h2m-33 1h1m1 0h3m1 0h1m1 0h1m1 0h1m3 0h2m1 0h1m3 0h7m2 0h1m-31 1h1m5 0h1m2 0h3m1 0h1m5 0h4m2 0h2m1 0h3m-31 1h7m1 0h1m1 0h1m2 0h3m1 0h1m4 0h3m1 0h2m3 0h1"/></svg>
</div>
<p class="eyebrow" style="margin:0">LinkedIn</p>
</div>
</div>

<!--
**⏱ ~45 s**

Repères : OBS aujourd'hui · Terramate en prod chez Additi : tout le SI sur Scaleway, piloté depuis GitLab CI · d'où ce talk
-->
---

<p class="eyebrow">Terraform, tout seul</p>
<h1>Root module, module, state</h1>

<div class="cols-code">
<div>

```text
infra/           ← root module
├── main.tf
├── backend.tf   ← où vit le state
└── prod.tfvars
modules/
└── cluster/     ← module, sans state
```

</div>
<div class="mini" style="grid-template-columns:1fr">
<div><b>Root module</b><p>Là où l'on lance <code>terraform plan</code>. Un state.</p></div>
<div><b>Module</b><p>Une brique appelée par <code>source</code>, sans state propre.</p></div>
<div><b>State · backend</b><p>Ce que Terraform sait du réel, avec un verrou.</p></div>
</div>
</div>

<p class="fixline">Terraform travaille sur un root module à la fois.</p>

<!--
**⏱ Le contexte : ~9 min**

Repères : trois mots, et c'est tout ce qu'il faut pour la suite · l'unité de travail de Terraform, c'est le root module · une commande, un dossier, un state

- Le root module : le dossier courant au moment du `terraform plan` (ou celui passé à `-chdir`). C'est lui qui a un backend, donc un state.
- Le module : appelé avec `module "x" { source = "../modules/cluster" }`. Ses ressources atterrissent dans le state du root module qui l'appelle. Un module partagé par dix root modules, c'est dix states qui le contiennent.
- Le state : la correspondance entre le code et les ressources réelles. Le backend (S3, GCS, azurerm…) le stocke et pose un verrou pendant un `apply`.
- Je dis Terraform, ça vaut pour OpenTofu.
-->

---

<p class="eyebrow">Structurer son code</p>
<h1>Les environnements : trois écoles</h1>

<div class="mini three">
<div><b>Workspaces</b><p>Un dossier, un state par workspace.</p><span class="fix">même structure partout</span></div>
<div><b>Un tfvars par env</b><p><code>-var-file</code> et <code>-backend-config</code>.</p><span class="fix">ne pas se tromper de fichier</span></div>
<div><b>Un dossier par env</b><p><code>envs/dev</code>, <code>envs/prod</code>, mêmes modules.</p><span class="fix">explicite, mais dupliqué</span></div>
</div>

<p class="fixline">Quelle que soit l'école : une commande, un root module, un state.</p>

<!--
Repères : ce qu'on trouve dans 90 % des repos · pas de bonne réponse universelle · le point commun : on reste sur un root module par exécution

- Workspaces : pratique pour des copies identiques. Dès que prod a besoin d'une ressource que dev n'a pas, on se retrouve avec des `count = terraform.workspace == "prod" ? 1 : 0`.
- tfvars + backend partiel : un seul dossier, la différence est dans les paramètres. Le risque, c'est l'erreur humaine : le tfvars de prod avec le backend de dev.
- Dossier par environnement : c'est le plus lisible, et le plus courant. Chaque dossier est un root module qui appelle les modules partagés.
- Ces trois écoles répondent à « comment avoir plusieurs environnements ». Elles ne répondent pas à « comment découper un environnement qui grossit ». C'est la suite.
-->

---

<p class="eyebrow">Le point de départ</p>
<h1>Un root module, un state, tout le SI</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:19rem" viewBox="0 0 760 280" role="img" aria-label="Un seul root module contient le réseau, Kubernetes, les bases et les applications de toutes les équipes, avec un seul state : le plan prend des minutes, un seul verrou bloque tout le monde, et une erreur peut toucher tout le SI."><defs><marker id="mo-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-box" x="20" y="20" width="400" height="240" rx="6" style="stroke-dasharray:6 5"></rect><text class="s-title" x="220" y="44" text-anchor="middle">un root module : infra/</text><rect class="s-box" x="40" y="62" width="110" height="40" rx="4"></rect><text class="s-lbl" x="95" y="87" text-anchor="middle">réseau</text><rect class="s-box" x="165" y="62" width="110" height="40" rx="4"></rect><text class="s-lbl" x="220" y="87" text-anchor="middle">Kubernetes</text><rect class="s-box" x="290" y="62" width="110" height="40" rx="4"></rect><text class="s-lbl" x="345" y="87" text-anchor="middle">IAM</text><rect class="s-box" x="40" y="114" width="110" height="40" rx="4"></rect><text class="s-lbl" x="95" y="139" text-anchor="middle">bases équipe A</text><rect class="s-box" x="165" y="114" width="110" height="40" rx="4"></rect><text class="s-lbl" x="220" y="139" text-anchor="middle">bases équipe B</text><rect class="s-box" x="290" y="114" width="110" height="40" rx="4"></rect><text class="s-lbl" x="345" y="139" text-anchor="middle">buckets</text><rect class="s-box" x="40" y="166" width="110" height="40" rx="4"></rect><text class="s-lbl" x="95" y="191" text-anchor="middle">DNS</text><rect class="s-box" x="165" y="166" width="110" height="40" rx="4"></rect><text class="s-lbl" x="220" y="191" text-anchor="middle">secrets</text><rect class="s-box" x="290" y="166" width="110" height="40" rx="4"></rect><text class="s-lbl" x="345" y="191" text-anchor="middle">…</text><text class="s-txt" x="220" y="236" text-anchor="middle">des milliers de ressources</text><line class="s-line" x1="422" y1="140" x2="486" y2="140" marker-end="url(#mo-a)"></line><rect class="s-badbox" x="490" y="110" width="110" height="60" rx="6"></rect><text class="s-title" x="545" y="137" text-anchor="middle">1 state</text><text class="s-txt" x="545" y="155" text-anchor="middle">1 verrou</text><text class="s-lbl-bad" x="620" y="60">plan : plusieurs minutes</text><text class="s-lbl-bad" x="620" y="78">rate limits des API</text><text class="s-lbl-bad" x="620" y="138">une équipe applique,</text><text class="s-lbl-bad" x="620" y="156">les autres attendent</text><text class="s-lbl-bad" x="620" y="214">une erreur = tout</text><text class="s-lbl-bad" x="620" y="232">le SI touché</text></svg></div>

<p class="fixline">Le réflexe : découper en plusieurs root modules, chacun son state.</p>

<!--
Repères : tout le monde a commencé comme ça · ça marche, jusqu'au jour où ça ne marche plus · trois douleurs : lenteur, verrou, blast radius

- Lenteur : chaque plan rafraîchit toutes les ressources. Des centaines d'appels API, des rate limits, des minutes.
- Verrou : un seul state, un seul lock. Deux personnes ne peuvent pas appliquer en même temps, même sur des sujets sans rapport.
- Blast radius : un `apply` sur le DNS peut, par erreur, toucher une base. Et les droits de la CI couvrent tout.
- La réponse classique, et la bonne : découper. Un root module par périmètre, chacun son state.
-->

---

<p class="eyebrow">Le découpage</p>
<h1>Un root module par périmètre</h1>

<div class="cols-code code-sm">
<div>

```text
socle/
├── reseau/       ← un state
└── kubernetes/   ← un autre
equipes/
└── paiement/
```

</div>
<div>
<p class="lbl">socle/kubernetes/reseau.tf</p>

```hcl
data "terraform_remote_state" "reseau" {
  backend = "s3"
  config  = { key = "socle/reseau/..." }
}

module "cluster" {
  source = "../../modules/cluster"
  vpc_id = data.terraform_remote_state.reseau.outputs.vpc_id
}
```

</div>
</div>

<p class="fixline">Le lien existe, par un <code>data</code>. L'ordre d'application, c'est à nous de le garantir.</p>

<!--
Repères : techniquement, ça marche très bien · des states petits, rapides, des droits par périmètre · mais la dépendance n'est écrite nulle part où Terraform pourrait la voir

- Chaque dossier a son backend, avec sa propre clé : quatre states indépendants.
- Les liens passent par des `data` : `terraform_remote_state`, ou une data source qui relit le VPC par son nom. Ça marche, mais c'est une lecture à l'exécution : Terraform ne s'en sert pas pour ordonner les root modules entre eux.
- Si le réseau n'est pas encore appliqué, le plan du cluster échoue : l'output n'existe pas. C'est l'humain qui sait dans quel ordre lancer.
-->

---

<p class="eyebrow">La limite</p>
<h1>Orchestration native ou blast radius maîtrisé</h1>

<div class="cols-code" style="margin-top:.6rem">
<div>
<p class="lbl">Un root module</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="y">orchestration native</li>
<li class="n">blast radius : tout</li>
</ul>
</div>
<div>
<p class="lbl">Plusieurs root modules</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="y">blast radius : un périmètre</li>
<li class="n">orchestration : à écrire</li>
</ul>
</div>
</div>

<p class="fixline">Entre root modules, les liens passent par des <code>data</code>. L'ordre : une boucle, un Makefile, la CI. À nous.</p>

<!--
Repères : LE message de cette partie · Terraform orchestre très bien, mais seulement à l'intérieur d'un root module · et là, il ne garantit rien sur le blast radius · découper règle le blast radius, et fait sortir l'orchestration de Terraform

- Dans un root module, Terraform construit un graphe : il sait que le cluster attend le VPC, et il applique en parallèle ce qui est indépendant (`-parallelism`, 10 par défaut). L'orchestration est interne, et elle marche.
- Mais tout est dans le même state : un `apply` peut toucher n'importe quelle ressource, et les droits de la CI couvrent tout. Terraform ne limite rien.
- On découpe : chaque root module a son state, ses droits, un périmètre restreint. Les liens restent possibles, avec des `data` (data sources, `terraform_remote_state`).
- Mais le graphe s'arrête au root module : `terraform` ne connaît que le dossier courant. L'ordre, ne lancer que le changé, le parallélisme entre dossiers : c'est nous qui les écrivons. Ça marche, mais l'ordre est codé en dur, la liste des dossiers aussi, et chaque nouveau root module oblige à toucher la CI.
- HashiCorp a sa réponse : Terraform Stacks. Mais c'est lié à HCP Terraform / Terraform Enterprise, pas à la CLI seule, et ça n'existe pas dans OpenTofu.
- Terramate, c'est garder le découpage, et retrouver une orchestration outillée.
-->

---

<p class="eyebrow">Le découpage</p>
<h1>Découper, c'est bien. Après, il faut tenir.</h1>

<div class="cards" style="grid-template-columns:1fr 1fr">
<div><b>Le copier-coller</b><p>Backend, providers, versions, tags : les mêmes 40 lignes dans chaque dossier. Et elles divergent.</p></div>
<div><b>L'ordre</b><p>Le réseau avant le cluster, le cluster avant les applis. Qui le sait ? Le README, au mieux.</p></div>
<div><b>Quoi lancer ?</b><p>Une MR touche un module partagé : quels dossiers planifier ? Tous, par sécurité. Et on retrouve la lenteur.</p></div>
<div><b>Le self-service</b><p>Une équipe veut une base. Elle copie un dossier voisin, ou elle ouvre un ticket.</p></div>
</div>

<!--
Repères : on a résolu un problème, on en a créé quatre · c'est exactement ce que Terramate adresse, dans cet ordre

- Copier-coller : la clé du backend surtout. Une clé dupliquée, c'est deux root modules qui écrivent dans le même state. Ça arrive.
- L'ordre : on vient de le voir, Terraform gère les dépendances DANS un root module, pas ENTRE root modules.
- Quoi lancer : sans détection de changements, la CI planifie tout, ou un humain choisit. Les deux sont mauvais.
- Self-service : c'est la partie platform engineering, on y vient avec les bundles.
-->

---

<p class="eyebrow">Terramate</p>
<h1>Un binaire, trois questions</h1>

<div class="pillars">
<div style="--c:var(--accent)"><h3>Orchestrer ?</h3><p>Des <b>stacks</b>, un ordre, la détection de changements par git. Seulement là où ça a changé.</p></div>
<div style="--c:var(--ochre)"><h3>Générer ?</h3><p>Des <b>globals</b>, <code>generate_hcl</code>, <code>tm_dynamic</code>, <code>generate_file</code> : écrit une fois, généré partout, commité.</p></div>
<div style="--c:var(--brick)"><h3>Donner en self-service ?</h3><p>Des <b>bundles</b> qui se demandent, s'exportent et se lient : les équipes remplissent un formulaire.</p></div>
</div>

<p class="fixline">CLI open source (MPL-2.0), écrite en Go. Terraform, OpenTofu et Terragrunt. Les fichiers <code>.tf</code> restent du Terraform pur.</p>

<p class="links"><a href="https://github.com/terramate-io/terramate">github.com/terramate-io/terramate</a> · <a href="https://terramate.io/docs/">terramate.io/docs</a></p>

<!--
Repères : un binaire Go, rien à installer côté runtime · trois questions, et à chaque fois la réponse est oui, et ça va loin · on peut adopter Terramate sur un repo existant sans réécrire une ligne de Terraform

- Différence clé avec Terragrunt : Terramate n'enveloppe pas Terraform. Il ne réécrit pas la commande, il ne remplace pas `terraform`. On lance `terramate run -- terraform plan`, ou `tofu`, ou `tflint`, ou n'importe quoi.
- Le code généré est commité dans le repo : ce qui est relu en MR, c'est ce qui tourne. Pas de génération cachée à l'exécution.
- Version utilisée pour ce talk : 0.17.3.
-->

---
layout: section
---

<p class="eyebrow">Chapitre 1</p>
<h1>Est-ce qu'on peut orchestrer ?</h1>

<!--
**⏱ Orchestration : ~8 min**
-->

---

<p class="eyebrow">L'unité de base</p>
<h1>Une stack, c'est un dossier</h1>

<div class="cols-code">
<div>

```hcl
# stacks/socle/kubernetes/stack.tm.hcl
stack {
  name        = "kubernetes"
  description = "Cluster Kubernetes du socle"
  tags        = ["socle", "kubernetes"]
  id          = "2f8e4a90-1b7c-4d2e-8f3a-..."

  after = ["tag:reseau"]
}
```

</div>
<div>

```text
stacks/
├── socle/
│   ├── reseau/         ← stack
│   └── kubernetes/     ← stack
└── equipes/
    └── paiement/
        ├── stockage/   ← stack
        └── base/       ← stack
```

</div>
</div>

<div class="cmds" style="margin-top:.6rem">
<code>terramate create stacks/socle/dns</code><span>une nouvelle stack</span>
<code>terramate create --all-terraform</code><span>adopter un repo existant : chaque root module devient une stack</span>
</div>

<!--
Repères : une stack = un root module + un fichier stack.tm.hcl · un state par stack · l'id est stable, le chemin peut bouger

- Une stack, c'est un dossier avec un bloc `stack`. Rien d'autre. Le Terraform à côté ne change pas.
- Les tags servent partout : filtrer (`--tags`), ordonner (`after = ["tag:reseau"]`), cibler en CI.
- L'id (un UUID) reste stable quand on déplace une stack : c'est la référence durable, le chemin peut changer.
- Les stacks peuvent s'imbriquer : un dossier parent stack, des enfants stacks.
- `create --all-terraform` : c'est le chemin d'adoption. On pose Terramate sur un repo existant en une commande.
-->

---

<p class="eyebrow">L'ordre</p>
<h1>Le dossier d'abord, puis <code>after</code> et <code>before</code></h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:15rem" viewBox="0 0 760 210" role="img" aria-label="Terramate ordonne les stacks : le réseau d'abord, puis le cluster Kubernetes déclaré after le tag réseau, puis les stacks des équipes. Les stacks indépendantes s'exécutent en parallèle avec --parallel ; --reverse inverse l'ordre pour détruire."><defs><marker id="or-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-hub" x="20" y="80" width="150" height="50" rx="6"></rect><text class="s-title" x="95" y="110" text-anchor="middle">reseau</text><rect class="s-box" x="250" y="30" width="170" height="50" rx="6"></rect><text class="s-title" x="335" y="52" text-anchor="middle">kubernetes</text><text class="s-txt" x="335" y="69" text-anchor="middle">after = ["tag:reseau"]</text><rect class="s-box" x="250" y="130" width="170" height="50" rx="6"></rect><text class="s-title" x="335" y="152" text-anchor="middle">paiement-base</text><text class="s-txt" x="335" y="169" text-anchor="middle">after = ["tag:reseau"]</text><rect class="s-box" x="500" y="30" width="200" height="50" rx="6"></rect><text class="s-title" x="600" y="52" text-anchor="middle">paiement-stockage</text><text class="s-txt" x="600" y="69" text-anchor="middle">after = ["tag:kubernetes"]</text><line class="s-line" x1="172" y1="96" x2="246" y2="60" marker-end="url(#or-a)"></line><line class="s-line" x1="172" y1="114" x2="246" y2="150" marker-end="url(#or-a)"></line><line class="s-line" x1="422" y1="55" x2="496" y2="55" marker-end="url(#or-a)"></line><rect class="s-zone" x="236" y="18" width="198" height="176" rx="8"></rect><text class="s-lbl-ok" x="335" y="206" text-anchor="middle">indépendantes : en parallèle avec --parallel</text></svg></div>

<div class="cmds">
<code>terramate list --run-order</code><span>l'ordre, sans rien exécuter</span>
<code>terramate run --parallel 4 -- tofu apply</code><span>l'ordre est respecté, le reste en parallèle</span>
<code>terramate run --reverse -- tofu destroy</code><span>l'ordre inverse, pour détruire</span>
</div>

<!--
Repères : ordre par défaut = hiérarchie des dossiers · after / before entre stacks, par chemin ou par tag · wants / wanted_by pour embarquer une stack dans l'exécution

- Un parent passe avant ses enfants. Entre frères : ordre alphabétique, sauf `after`/`before`.
- `after = ["tag:reseau"]` : pas besoin de connaître les chemins. Toute stack taggée reseau passe avant.
- Attention : `after` ordonne, il n'embarque pas. Si seule la stack kubernetes a changé, le réseau ne tourne pas. Pour embarquer : `wants`.
- Ce n'est PAS un passage d'outputs entre stacks. Pour ça : data sources, remote state, ou l'output sharing de Terramate (encore à part).
-->

---

<p class="eyebrow">La détection de changements</p>
<h1>Ne lancer que ce qui a changé</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:16rem" viewBox="0 0 760 230" role="img" aria-label="Terramate compare la branche à main avec git. Une stack est changée si un de ses fichiers a changé, si un module local qu&#x27;elle appelle a changé, ou si un fichier listé dans watch a changé. Les autres stacks ne tournent pas."><defs><marker id="cd-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="cd-t" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker></defs><rect class="s-box" x="20" y="80" width="160" height="70" rx="6"></rect><text class="s-title" x="100" y="108" text-anchor="middle">git diff</text><text class="s-txt" x="100" y="128" text-anchor="middle">main…HEAD</text><text class="s-lbl" x="300" y="34" text-anchor="middle">un fichier de la stack</text><text class="s-lbl" x="300" y="106" text-anchor="middle">un module local appelé</text><text class="s-lbl" x="300" y="202" text-anchor="middle">un fichier dans watch</text><line class="s-line" x1="182" y1="96" x2="420" y2="40" marker-end="url(#cd-a)"></line><line class="s-line" x1="182" y1="115" x2="420" y2="115" marker-end="url(#cd-a)"></line><line class="s-line" x1="182" y1="134" x2="420" y2="190" marker-end="url(#cd-a)"></line><rect class="s-okbox" x="424" y="18" width="150" height="44" rx="5"></rect><text class="s-title" x="499" y="45" text-anchor="middle">kubernetes</text><rect class="s-okbox" x="424" y="93" width="150" height="44" rx="5"></rect><text class="s-title" x="499" y="120" text-anchor="middle">kubernetes</text><rect class="s-okbox" x="424" y="168" width="150" height="44" rx="5"></rect><text class="s-title" x="499" y="195" text-anchor="middle">dns</text><rect class="s-box" x="610" y="60" width="130" height="110" rx="6" style="stroke-dasharray:6 5"></rect><text class="s-txt" x="675" y="98" text-anchor="middle">reseau</text><text class="s-txt" x="675" y="118" text-anchor="middle">paiement-*</text><text class="s-txt" x="675" y="138" text-anchor="middle">…</text><text class="s-lbl-bad" x="675" y="190" text-anchor="middle">ne tournent pas</text></svg></div>

<div class="cmds">
<code>terramate list --changed --why</code><span>quelles stacks, et pourquoi</span>
<code>terramate run --changed -- tofu plan</code><span>le plan de la MR, et rien d'autre</span>
</div>

<!--
Repères : c'est LA fonctionnalité · basé sur git, rien à stocker · sur une branche : comparé à main · sur main : comparé au commit précédent

- Sur une branche, la base est `origin/main`. Sur main, c'est le commit précédent (`HEAD^`), donc l'apply après merge ne rejoue que ce qui vient d'être mergé. Surchargeable avec `--git-change-base`. Ça suppose un commit par merge (merge commit ou squash) : en rebase, plusieurs commits arrivent d'un coup, passer explicitement la base.
- Les modules locaux sont suivis : modifier `modules/cluster` marque toutes les stacks qui l'appellent. Ça, ça vaut le prix d'entrée.
- `watch` : pour un fichier que Terraform lit sans que Terramate le voie (un YAML lu par `file()`, par exemple).
- `--why` explique chaque stack : précieux pour déboguer une CI qui en lance trop.
- Il existe aussi `terramate trigger` pour forcer une stack dans la prochaine exécution, sans modifier son code.
-->

---

<p class="eyebrow">Les workflows</p>
<h1>Des scripts, et des garde-fous</h1>

<div class="cols-code">
<div>

```hcl
script "deploiement" {
  description = "init + plan + apply"

  job {
    commands = [
      ["tofu", "init"],
      ["tofu", "plan", "-out=plan.tfplan"],
      ["tofu", "apply", "plan.tfplan"],
    ]
  }
}
```

<div class="cmds"><code>terramate script run --changed deploiement</code></div>

</div>
<div>

<p class="lbl">terramate run refuse de tourner si…</p>
<ul class="yesno">
<li class="n">des fichiers ne sont pas commités</li>
<li class="n">le code généré est périmé</li>
<li class="n">la branche n'est pas à jour avec le remote</li>
</ul>
<p class="muted" style="font-size:.85rem;margin-top:1rem">Chaque garde-fou se désactive, au cas par cas : <code>--disable-safeguards</code>.</p>

</div>
</div>

<!--
Repères : un script = un workflow nommé, déclaré une fois, hérité par les dossiers en dessous · les garde-fous : ce qui tourne, c'est ce qui est commité

- Un script se déclare à n'importe quel niveau et s'applique aux stacks en dessous : un `deploiement` différent pour une partie du repo, c'est possible.
- Les scripts sont encore derrière `experiments = ["scripts"]` en 0.17. Ça marche bien, mais c'est un signal.
- Les garde-fous : on les découvre en démo. Ils énervent la première semaine, puis on ne s'en passe plus.
-->

---

<p class="eyebrow">En CI</p>
<h1>Une pipeline pour tout le repo</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:13rem" viewBox="0 0 760 170" role="img" aria-label="Sur une merge request, la CI lance terramate run --changed avec un plan, et poste le plan. Après le merge sur main, la CI lance terramate run --changed avec un apply, sur les seules stacks modifiées."><defs><marker id="ci-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-box" x="20" y="20" width="160" height="50" rx="6"></rect><text class="s-title" x="100" y="50" text-anchor="middle">merge request</text><line class="s-line" x1="182" y1="45" x2="246" y2="45" marker-end="url(#ci-a)"></line><rect class="s-hub" x="250" y="20" width="300" height="50" rx="6"></rect><text class="s-title" x="400" y="50" text-anchor="middle">terramate run --changed -- tofu plan</text><line class="s-line" x1="552" y1="45" x2="606" y2="45" marker-end="url(#ci-a)"></line><rect class="s-box" x="610" y="20" width="130" height="50" rx="6"></rect><text class="s-lbl" x="675" y="50" text-anchor="middle">plan relu en MR</text><rect class="s-box" x="20" y="100" width="160" height="50" rx="6"></rect><text class="s-title" x="100" y="130" text-anchor="middle">merge sur main</text><line class="s-line" x1="182" y1="125" x2="246" y2="125" marker-end="url(#ci-a)"></line><rect class="s-hub" x="250" y="100" width="300" height="50" rx="6"></rect><text class="s-title" x="400" y="130" text-anchor="middle">terramate run --changed -- tofu apply</text><line class="s-line" x1="552" y1="125" x2="606" y2="125" marker-end="url(#ci-a)"></line><rect class="s-okbox" x="610" y="100" width="130" height="50" rx="6"></rect><text class="s-lbl" x="675" y="130" text-anchor="middle">seules ces stacks</text></svg></div>

<div class="cmds">
<code>terramate run --tags rotating -- tofu apply</code><span>un job planifié, sur un sous-ensemble de stacks</span>
<code>terramate run --continue-on-error</code><span>ne pas tout arrêter pour une stack en échec</span>
</div>

<p class="fixline">Pas de job par dossier à maintenir : la CI ne connaît que Terramate.</p>

<!--
Repères : deux jobs, pas cinquante · la CI ne connaît pas la liste des stacks · une nouvelle stack est prise en compte sans toucher la CI

- Chez Additi, sur GitLab CI : plan sur les MR, apply sur main, tout via `--changed`.
- Et un job planifié : la rotation des clés API Scaleway, les jours ouvrés à 6 h, sur les stacks taggées `rotating` (cf. le talk Scaleway). C'est exactement l'usage des tags.
- Attention au clone en CI : la détection a besoin de l'historique git. Un clone trop superficiel (`depth: 1`) et il n'y a plus de base de comparaison.
- Terramate fournit des exemples prêts pour GitHub Actions, GitLab CI, Bitbucket… Poster le plan en commentaire de MR, c'est à nous de l'outiller.
-->

---
layout: section
---

<p class="eyebrow">Chapitre 2</p>
<h1>Est-ce qu'on peut générer ?</h1>

<!--
**⏱ Génération : ~8 min**
-->

---

<p class="eyebrow">Les globals</p>
<h1>Des variables qui descendent l'arborescence</h1>

<div class="grid grid-cols-2 gap-8" style="align-items:center">
<div class="diagram-wrap"><svg class="diagram" style="max-height:18rem" viewBox="0 0 380 290" role="img" aria-label="Les globals se déclarent à la racine, dans un dossier, ou dans une stack. Une stack hérite de tous ses parents ; le niveau le plus proche l&#x27;emporte."><defs><marker id="gl-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-hub" x="20" y="10" width="340" height="62" rx="6"></rect><text class="s-title" x="36" y="34">/ · globals.tm.hcl</text><text class="s-txt" x="36" y="56">organisation = "demo" · region = "fr-par"</text><line class="s-line" x1="60" y1="74" x2="60" y2="104" marker-end="url(#gl-a)"></line><rect class="s-box" x="40" y="108" width="320" height="62" rx="6"></rect><text class="s-title" x="56" y="132">/stacks/equipes · globals.tm.hcl</text><text class="s-txt" x="56" y="154">region = "nl-ams"</text><line class="s-line" x1="80" y1="172" x2="80" y2="202" marker-end="url(#gl-a)"></line><rect class="s-okbox" x="60" y="206" width="300" height="72" rx="6"></rect><text class="s-title" x="76" y="230">la stack paiement-base voit :</text><text class="s-txt" x="76" y="250">organisation = "demo"</text><text class="s-txt" x="76" y="268">region = "nl-ams"   ← le plus proche gagne</text></svg></div>
<div>

```hcl
globals {
  organisation  = "demo"
  region        = "fr-par"
  environnement = "prod"
  tofu_version  = "~> 1.10"
}
```

<div class="cmds" style="margin-top:.6rem">
<code>terramate debug show globals</code><span>ce que voit chaque stack</span>
</div>

</div>
</div>

<!--
Repères : héritage par dossier · le plus proche gagne · pas de variable Terraform : ça n'existe qu'à la génération

- Les globals ne sont pas des variables Terraform : elles n'existent que pour Terramate, au moment de la génération et de l'exécution.
- Elles peuvent référencer d'autres globals et les métadonnées de la stack (`terramate.stack.name`, `terramate.stack.path.relative`, `terramate.stack.tags`…).
- `lets` pour des valeurs locales à un générateur, `map` pour construire des objets.
- `debug show globals` : indispensable dès que l'arborescence grossit. Sans ça, l'héritage devient vite opaque.
-->

---

<p class="eyebrow">generate_hcl</p>
<h1>Le backend, écrit une fois</h1>

<div class="cols-code code-sm">
<div>
<p class="lbl">imports/backend.tm.hcl</p>

```hcl
generate_hcl "_backend.tf" {
  content {
    terraform {
      backend "s3" {
        bucket = "${global.organisation}-tfstate"
        region = global.region
        key    = "${terramate.stack.path.relative}/tfstate"
      }
    }
  }
}
```

</div>
<div>
<p class="lbl">stacks/socle/kubernetes/_backend.tf</p>

```hcl
// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket = "demo-tfstate"
    region = "fr-par"
    key    = "stacks/socle/kubernetes/tfstate"
  }
}
```

</div>
</div>

<p class="fixline">La clé du state dérive du chemin : deux stacks ne peuvent plus partager un state par erreur.</p>

<!--
Repères : à gauche, ce qu'on écrit une fois · à droite, ce qui est généré dans chaque stack · la clé du state vient du chemin

- `terramate generate` écrit le fichier dans chaque stack concernée. Et il est commité : il apparaît dans la MR, il est relu.
- Un garde-fou vérifie que le code généré est à jour avant chaque `run` : impossible d'oublier de régénérer.
- Même logique pour les providers, les versions, les tags par défaut, les `locals` communs.
- Variante recommandée par la doc : une clé basée sur `terramate.stack.id` plutôt que sur le chemin. On peut alors déplacer une stack sans migrer son state.
-->

---

<p class="eyebrow">tm_dynamic</p>
<h1>Des blocs générés en boucle</h1>

<div class="cols-code code-sm">
<div>
<p class="lbl">imports/services.tm.hcl (extrait)</p>

```hcl
tm_dynamic "resource" {
  for_each = global.services   # api, worker
  iterator = svc
  labels   = ["terraform_data", svc.key]
  content {
    input = {
      port  = svc.value.port
      acces = tm_ternary(svc.value.public, "internet", "interne")
      env   = tm_hcl_expression("local.environnement")
    }
    tm_dynamic "lifecycle" {
      condition = svc.value.public
      content {
        create_before_destroy = true
      }
    }
  }
}
```

</div>
<div>
<p class="lbl">ce qu'on peut faire</p>
<ul class="mini-list">
<li><code>for_each</code> + <code>iterator</code> : un bloc par élément d'une global</li>
<li><code>labels</code> : le type et le nom du bloc généré</li>
<li><code>content</code> ou <code>attributes = {…}</code> : le corps du bloc</li>
<li><code>condition</code> : le bloc existe, ou pas</li>
<li>imbriqué : un <code>tm_dynamic</code> dans un <code>tm_dynamic</code></li>
<li>les références Terraform (<code>local.x</code>, <code>var.x</code>) restent telles quelles</li>
</ul>
<p class="muted" style="font-size:.85rem">Dans la démo : un <code>terraform_data</code> et un <code>output</code> par service, depuis une map de globals.</p>
</div>
</div>

<!--
Repères : le `dynamic` de Terraform, mais au moment de la génération · une boucle sur une global, des blocs de n'importe quel type · l'exemple complet est dans la démo

- `tm_dynamic` prend un label : le type de bloc à générer (`resource`, `provider`, `module`, `output`, `lifecycle`, même `dynamic`).
- `for_each` sur une liste ou une map, `iterator` pour nommer la variable (par défaut, le label). Les valeurs de l'itérateur et des globals sont inlinées dans le fichier généré.
- Les références Terraform (`var.x`, `local.x`, `each.value`) sont gardées telles quelles : c'est l'évaluation partielle. On mélange les deux mondes sans conflit.
- `attributes = { … }` : pour générer des attributs depuis une map, par exemple tout le `required_providers` d'une global.
- `condition` : ici, `create_before_destroy` seulement pour les services publics.
- Dans la démo (`imports/services.tm.hcl`) : aussi un `lets`, un `assert`, un `stack_filter`, et un second `tm_dynamic "output"` construit avec `attributes`.
- Pourquoi pas un `dynamic` Terraform ? Le `dynamic` ne sait pas générer un `resource`, un `provider` ou un `module` : seulement des blocs imbriqués. `tm_dynamic` génère n'importe quel bloc, y compris des providers par région.
- Limite : un bloc sur une ligne avec plusieurs arguments est refusé par le parseur. On écrit un argument par ligne.
-->

---

<p class="eyebrow">generate_file</p>
<h1>Pas que du HCL</h1>

<div class="cols-code code-sm">
<div>
<p class="lbl">imports/catalogue.tm.hcl</p>

```hcl
generate_file "catalog-info.yaml" {
  content = tm_yamlencode({
    apiVersion = "backstage.io/v1alpha1"
    kind       = "Component"
    metadata = {
      name        = terramate.stack.name
      description = terramate.stack.description
    }
    spec = {
      owner = global.proprietaire
    }
  })
}
```

</div>
<div>
<p class="lbl">stacks/socle/kubernetes/catalog-info.yaml</p>

```yaml
"apiVersion": "backstage.io/v1alpha1"
"kind": "Component"
"metadata":
  "description": "Cluster Kubernetes du socle"
  "name": "kubernetes"
"spec":
  "owner": "plateforme"
```

</div>
</div>

<p class="fixline">N'importe quel fichier, dans chaque stack : YAML, JSON, <code>.tflint.hcl</code>, <code>CODEOWNERS</code>, un workflow de CI…</p>

<!--
Repères : generate_hcl pour le Terraform, generate_file pour tout le reste · le contenu est une chaîne : un template, ou une fonction d'encodage · même règles : commité, vérifié avant chaque run

- Ici, une fiche Backstage par stack : le catalogue de services se remplit tout seul.
- `tm_yamlencode`, `tm_jsonencode`, ou un heredoc avec interpolation. `tm_yamlencode` met des guillemets partout : du YAML valide, un peu lourd à l'œil.
- La démo a aussi une `annotation` et un `type` : version complète dans `imports/catalogue.tm.hcl`.
- Limite : le nom du fichier est un littéral, pas de `${…}` dedans. On choisit le dossier avec `stack_filter`, et on peut aussi générer hors des stacks (`context = root`).
-->

---

<p class="eyebrow">La boîte à outils</p>
<h1>Générer juste ce qu'il faut, là où il faut</h1>

<div class="mini">
<div><b><code>condition</code> · <code>stack_filter</code></b><p>Générer seulement pour certaines stacks : un tag, un chemin, une valeur de global.</p></div>
<div><b><code>lets</code> · <code>tm_*</code></b><p>Des valeurs locales au générateur, et les fonctions Terraform préfixées : <code>tm_ternary</code>, <code>tm_try</code>…</p></div>
<div><b><code>assert</code></b><p>Une règle vérifiée au <code>generate</code> : pas de région, pas de code.</p></div>
<div><b><code>import</code></b><p>Partager des générateurs entre dossiers, ou entre repos : une bibliothèque de conventions.</p></div>
</div>

<p class="fixline">Générer la plomberie (backend, providers, conventions). La logique métier reste dans des modules Terraform.</p>

<!--
Repères : quatre outils autour des générateurs · ce qui se vérifie au generate ne casse pas à l'apply

- `condition` évalue par stack ; `stack_filter` filtre par chemin, plus simple à lire, évalué avant.
- `lets` : une valeur calculée une fois dans le générateur (`let.prefixe`).
- `assert` : `assertion` + `message`, et `warning = true` pour un simple avertissement.
- `tm_hcl_expression` : construire une référence Terraform à partir d'une chaîne (`var.${nom}_taille`).
- Mon conseil : c'est puissant, donc on peut en faire trop. Générer le plomberie, pas la logique.
-->

---
layout: section
---

<p class="eyebrow">Chapitre 3</p>
<h1>Est-ce qu'on peut donner en self-service ?</h1>

<!--
**⏱ Self-service : ~9 min**
-->

---

<p class="eyebrow">Platform engineering</p>
<h1>Les équipes ne devraient pas écrire de HCL</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:17rem" viewBox="0 0 760 250" role="img" aria-label="L&#x27;équipe plateforme écrit des composants, des briques Terraform, et les assemble en bundles. Une équipe produit instancie un bundle avec quelques lignes de YAML. terramate generate en tire les stacks et le code, que terramate run déploie."><defs><marker id="ca-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><text class="s-title" x="20" y="22">Équipe plateforme</text><rect class="s-zone" x="10" y="32" width="390" height="120" rx="8"></rect><rect class="s-box" x="25" y="50" width="150" height="38" rx="5"></rect><text class="s-lbl" x="100" y="74" text-anchor="middle">composant · bucket</text><rect class="s-box" x="25" y="100" width="150" height="38" rx="5"></rect><text class="s-lbl" x="100" y="124" text-anchor="middle">composant · base</text><line class="s-line" x1="177" y1="69" x2="226" y2="88" marker-end="url(#ca-a)"></line><line class="s-line" x1="177" y1="119" x2="226" y2="102" marker-end="url(#ca-a)"></line><rect class="s-hub" x="230" y="66" width="155" height="56" rx="6"></rect><text class="s-title" x="307" y="90" text-anchor="middle">bundle</text><text class="s-txt" x="307" y="108" text-anchor="middle">« espace d'équipe »</text><text class="s-title" x="20" y="190">Équipe produit</text><rect class="s-okbox" x="25" y="200" width="200" height="40" rx="5"></rect><text class="s-lbl" x="125" y="225" text-anchor="middle">paiement.tm.yml · 11 lignes</text><line class="s-line" x1="227" y1="215" x2="300" y2="128" marker-end="url(#ca-a)" style="stroke-dasharray:4 4"></line><text class="s-lbl" x="268" y="188">instancie</text><line class="s-line" x1="387" y1="94" x2="456" y2="94" marker-end="url(#ca-a)"></line><rect class="s-box" x="460" y="60" width="140" height="68" rx="6"></rect><text class="s-title" x="530" y="88" text-anchor="middle">terramate</text><text class="s-title" x="530" y="106" text-anchor="middle">generate</text><line class="s-line" x1="602" y1="94" x2="636" y2="94" marker-end="url(#ca-a)"></line><rect class="s-box" x="640" y="44" width="110" height="34" rx="5"></rect><text class="s-lbl" x="695" y="66" text-anchor="middle">stack stockage</text><rect class="s-box" x="640" y="110" width="110" height="34" rx="5"></rect><text class="s-lbl" x="695" y="132" text-anchor="middle">stack base</text><text class="s-txt" x="695" y="170" text-anchor="middle">+ le code, commité</text></svg></div>

<p class="fixline">La plateforme publie un catalogue. Les équipes le consomment, sans connaître Terraform.</p>

<!--
Repères : le volet platform engineering de Terramate · dans la CLI open source depuis la 0.16 (février 2026), après une bêta privée sous le nom « Catalyst » · encore marqué bêta dans la doc · composant, bundle, instance

- Avant les bundles : on faisait ça avec des modules Terraform et de la génération. Ça marche, mais l'équipe produit écrit quand même du HCL, et connaît la structure du repo.
- Avec les bundles, trois niveaux :
  - **composant** : une brique d'infra, avec des entrées typées. Écrit par la plateforme.
  - **bundle** : un assemblage de composants en stacks, avec ses propres entrées, ses conditions, ses chemins. Écrit par la plateforme. C'est le « produit » du catalogue.
  - **instance** : un fichier YAML ou HCL qui remplit les entrées d'un bundle. Écrit par l'équipe produit.
- Les bundles et composants se versionnent, et peuvent venir d'un autre repo (packages).
- Il y a aussi la notion d'environnements (dev, prod…) avec promotion d'une instance d'un environnement à l'autre.
-->

---

<p class="eyebrow">Ce qu'écrit la plateforme</p>
<h1>Un composant, un bundle</h1>

<div class="cols-code code-sm">
<div>

```hcl
define component metadata {
  class   = "demo.io/base-de-donnees"
  version = "1.0.0"
  name    = "Base PostgreSQL"
}

define component input "taille" {
  type    = string
  default = "S"
}

generate_hcl "main.tf" {
  content {
    resource "scaleway_rdb_instance" "base" {
      node_type = component.input.taille.value
      # ...
    }
  }
}
```

</div>
<div>

```hcl
define bundle input "equipe" {
  type = string
}

define bundle input "base" {
  type    = bool
  default = false
}

define bundle stack "base" {
  condition = bundle.input.base.value
  metadata {
    path  = "/stacks/equipes/${bundle.input.equipe.value}/base"
    after = ["tag:reseau"]
  }
  component "base" {
    source = "/catalogue/composants/base-de-donnees/v1"
    inputs { taille = bundle.input.taille_base.value }
  }
}
```

</div>
</div>

<!--
Repères : à gauche, la brique · à droite, le produit · le bundle décide des stacks, de leurs chemins, de leur ordre

- Le composant : des entrées typées, et un `generate_hcl` qui produit le Terraform. Pas de variables Terraform, pas de tfvars.
- Le bundle : ses entrées, et des `define bundle stack`. Chaque stack a un chemin calculé, des tags, un ordre (`after`), une condition. Ici, pas de base si l'équipe n'en demande pas.
- L'équipe ne choisit pas où vont ses stacks, ni comment s'appelle son state : la plateforme garde la main sur les conventions.
- Dans la démo, les ressources sont des `terraform_data` pour tourner hors ligne ; sur la slide, une vraie ressource Scaleway pour l'exemple.
-->

---

<p class="eyebrow">Demander</p>
<h1>Des entrées typées, et la question à poser</h1>

<div class="cols-code code-sm">
<div>

```hcl
define bundle input "taille_base" {
  type        = string
  description = "Gabarit de la base"
  default     = "S"
  prompt {
    text    = "Gabarit de la base"
    options = ["S", "M", "L"]
  }
}
```

</div>
<div>
<p class="lbl">ce que décrit une entrée</p>
<ul class="mini-list">
<li><code>type</code> : <code>string</code>, <code>bool</code>, <code>list</code>, <code>object</code>… ou un autre bundle</li>
<li>sans <code>default</code>, l'entrée est obligatoire</li>
<li><code>prompt</code> : le texte, les <code>options</code>, <code>multiline</code>, <code>multiselect</code>, une <code>condition</code> d'affichage</li>
<li><code>immutable</code> : on ne la change plus après création</li>
</ul>
<p class="muted" style="font-size:.85rem"><code>terramate ui</code> lit les <code>prompt</code> et en fait un formulaire.</p>
</div>
</div>

<!--
Repères : le contrat du bundle, c'est ses entrées · le prompt, c'est l'expérience développeur · le formulaire est généré, pas codé

- `type` : les types HCL classiques, des objets avec des sous-attributs (`attribute "x" { required = true }`), et `bundle("classe")` pour référencer un autre bundle (slide suivante).
- `prompt.options` accepte une expression : par exemple la liste des zones existantes, avec `tm_bundles("demo.io/zone")`.
- `prompt.condition` : n'afficher la question que si elle a du sens (pas de gabarit si pas de base). Lu dans le code de la 0.17.3, pas testé en démo.
- `immutable` : le nom d'une équipe, typiquement. On ne renomme pas un chemin de state par mégarde.
- Attention : `prompt`, `options` en attribut direct sont dépréciés depuis la 0.17. C'est le bloc `prompt { }`.
-->

---

<p class="eyebrow">Exporter et lier</p>
<h1>Des bundles qui se parlent</h1>

<div class="cols-code code-sm">
<div>
<p class="lbl">bundle zone : la plateforme expose</p>

```hcl
define bundle {
  alias = bundle.input.nom.value      # « paris »
}

define bundle export "subnet_id" {
  value = "subnet-${bundle.input.nom.value}"
}
```

</div>
<div>
<p class="lbl">bundle espace-equipe : l'équipe consomme</p>

```hcl
define bundle input "zone" {
  type = bundle("demo.io/zone")
  prompt {
    text = "Zone réseau"
  }
}

subnet_id = bundle.input.zone.value.export.subnet_id.value
```

</div>
</div>

<p class="fixline">L'équipe choisit « paris » dans une liste. Le sous-réseau arrive tout seul dans son code.</p>

<!--
Repères : LA partie la plus intéressante · un bundle publie des valeurs, un autre les consomme · on compose des briques de plateforme au lieu de copier des identifiants

- `define bundle export "x" { value = … }` : ce que le bundle rend public. Ici, l'identifiant du sous-réseau et le CIDR de la zone.
- Côté consommateur : une entrée de type `bundle("demo.io/zone")`. Dans le YAML, on écrit l'alias (`zone: paris`). Dans `terramate ui`, c'est une liste des zones existantes.
- La valeur est un objet : `alias`, `class`, `input`, `export`… On lit `.export.subnet_id.value` (attention, `export` au singulier, et `.value` au bout).
- `tm_bundle(classe, alias)` et `tm_bundles(classe)` : les mêmes liens, depuis n'importe quel générateur.
- L'alias : sans `define bundle { alias = … }`, il vaut `<dossier>:<nom>`. On le fixe pour que les équipes le lisent.
- Piège : le lien ne crée PAS d'ordre d'exécution. Il faut `after = ["tag:zone"]` sur les stacks de l'équipe. Dans la démo, c'est fait.
- Ne pas survendre : un export est calculé au `generate`, à partir des entrées du bundle. `subnet-paris` est une chaîne construite, pas l'ID réel lu dans un state. Pour une valeur connue seulement après l'`apply`, on repasse par une data source ou du remote state dans le code Terraform.
- Pour aller plus loin : les environnements (`environment { id = "prod" promote_from = "dev" }`), une instance par environnement, et la promotion dev → prod dans `terramate ui`. Pas dans la démo.
- Dans la démo : `plateforme/zone-paris.tm.yml` instancie la zone, `equipes/paiement.tm.yml` s'y lie.
-->

---

<p class="eyebrow">Ce qu'écrit une équipe</p>
<h1>11 lignes de YAML</h1>

<div class="cols-code">
<div>
<p class="lbl">equipes/paiement.tm.yml</p>

```yaml
apiVersion: terramate.io/cli/v1
kind: BundleInstance
metadata:
  name: paiement
spec:
  source: /catalogue/bundles/espace-equipe/v1
  inputs:
    equipe: paiement
    zone: paris
    base: true
    taille_base: M
```

</div>
<div>
<p class="lbl">terramate generate</p>

```text
- /stacks/equipes/paiement/base
	[+] component_base_main.tf
	[+] stack.tm.hcl
	[+] _terramate_backend.tf
- /stacks/equipes/paiement/stockage
	[+] component_bucket_main.tf
	[+] stack.tm.hcl
	[+] _terramate_backend.tf
```

<div class="cmds" style="margin-top:.6rem">
<code>terramate ui</code><span>un formulaire, plutôt que du YAML</span>
</div>

</div>
</div>

<!--
Repères : du YAML, façon manifeste Kubernetes · ou un formulaire dans le terminal · le reste est généré, et passe par la même MR, la même CI

- Le format ressemble volontairement à un manifeste Kubernetes : apiVersion, kind, metadata, spec. Les équipes produit le connaissent déjà.
- `terramate ui` (0.17) : un TUI qui liste les bundles du catalogue, pose les questions (les `prompt` des entrées), écrit le fichier. Il sait aussi reconfigurer une instance et la promouvoir d'un environnement à l'autre. Successeur de `terramate scaffold`.
- Ensuite, rien de nouveau : `generate`, MR, `run --changed`. Le self-service passe par le même chemin que le reste. Pas de portail à côté, pas de backend à opérer.
-->

---
layout: section
---

<p class="eyebrow">Démo</p>
<h1>Sur le terminal</h1>

<!--
**⏱ Démo : ~11 min.** Scénario complet et commandes : `terramate/demo/README.md`.

Préparation : `./terramate/demo/prepare.sh /tmp/terramate-demo`, terminal en gros caractères, thème clair. Garder un second terminal où la démo est déjà jouée jusqu'à l'étape 5 (plan B).
-->

---

<p class="eyebrow">Démo · le programme</p>
<h1>Un socle, deux équipes, zéro cloud</h1>

<div class="steps">
<span class="n">1</span><b>Les stacks et l'ordre</b><span><code>terramate list --run-order</code></span>
<span class="n">2</span><b>La génération</b><span><code>generate</code>, <code>tm_dynamic</code>, <code>generate_file</code>, le premier garde-fou</span>
<span class="n">3</span><b>L'orchestration</b><span><code>run --parallel</code>, <code>script run</code>, <code>--tags</code></span>
<span class="n">4</span><b>La détection</b><span>une branche, un module, <code>list --changed --why</code></span>
<span class="n">5</span><b>Le self-service</b><span>une équipe avec <code>terramate ui</code>, liée à la zone <code>paris</code></span>
</div>

<p class="fixline">OpenTofu, des <code>terraform_data</code>, un backend local : tout tourne hors ligne.</p>

<!--
Repères : annoncer les 5 étapes, puis basculer sur le terminal · revenir sur cette slide entre les étapes si besoin

1. `terramate list --run-order` : reseau, puis kubernetes. Pas encore d'équipe : les stacks du bundle naissent au `generate`.
2. `terramate generate`, montrer `_terramate_backend.tf`, puis `imports/services.tm.hcl` et le `_terramate_services.tf` généré (un `terraform_data` et un `output` par service), puis un `catalog-info.yaml`. Relancer `list --run-order` : la zone `paris` et les stacks de paiement sont là, à leur place. Lancer `terramate run -- tofu init` : refusé, fichiers non commités. Commit, relancer.
3. `terramate run --parallel 4 -- tofu apply -auto-approve`, puis `terramate script run deploiement`, puis `terramate list --tags socle`.
4. Branche `montee-k8s`, passer 1.34 en 1.35, commit, `terramate list --changed --why` : une stack. Puis une modif du module : la stack qui l'appelle, avec la raison.
5. Branche `equipe-catalogue`, montrer l'export de la zone, `terramate ui` (ou le sed du README) en choisissant la zone `paris`, `terramate generate`, montrer `subnet_id = "subnet-paris"` dans le code généré, commit, `terramate list --changed` : seulement les stacks de la nouvelle équipe. `run --changed -- tofu apply`.

Si le TUI pose problème en live : le sed du README fait la même chose.
-->

---
layout: section
---

<p class="eyebrow">Pour finir</p>
<h1>Le reste du paysage</h1>

<!--
**⏱ Fin : ~3 min**
-->

---

<p class="eyebrow">La question qui vient toujours</p>
<h1>Et Terragrunt ?</h1>

<div class="cols-code" style="margin-top:.6rem">
<div>
<p class="lbl">Ce qu'il fait bien</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="y">les vrais outputs du state</li>
<li class="y">le changé par git, suppressions comprises</li>
<li class="y">des stacks régénérées</li>
</ul>
</div>
<div>
<p class="lbl">Ce qui coince</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="n">pas de formulaire pour les équipes</li>
<li class="n">le code généré, non relu</li>
<li class="n">un DSL de plus : <code>terragrunt.hcl</code></li>
</ul>
</div>
</div>

<p class="fixline">La vraie différence : le platform engineering. Et Terramate sait orchestrer un repo Terragrunt.</p>

<p class="links"><a href="https://github.com/gruntwork-io/terragrunt">github.com/gruntwork-io/terragrunt</a> · <a href="https://docs.terragrunt.com/">docs.terragrunt.com</a></p>

<!--

Le tableau complet, à dire si on a le temps :

| | Terragrunt | Terramate |
|---|---|---|
| Rapport à Terraform | l'enveloppe : `terragrunt plan` | le lance : `terramate run -- tofu plan` |
| Le code | `terragrunt.hcl` + modules, résolu à l'exécution | Terraform pur + code généré, commité |
| Ordre | `dependency`, avec passage d'outputs | `after` / `before`, sans passage d'outputs |
| Le changé | `--filter-affected`, par git | `--changed`, par git |
| Self-service | stacks : régénérées, sans formulaire, non commitées | bundles : formulaire, régénérés, commités |
| Liens | `dependency` : les vrais outputs du state | exports : calculés au `generate` |
| CI clé en main | Terragrunt Scale (payant au-delà de 25 unités) | à outiller soi-même |
| Point fort | partir de zéro | reprendre l'existant : `create --all-terraform` |

Repères : pas une guerre de religion · deux philosophies : envelopper vs orchestrer · on peut combiner

- Le vrai point fort de Terragrunt : `dependency` qui passe les outputs d'une unité à l'autre. Chez Terramate, l'équivalent (output sharing) existe mais reste à part ; on fait souvent avec des data sources ou du remote state.
- Le vrai point fort de Terramate : la détection par git, et le fait que le code reste du Terraform standard. Un nouvel arrivant lit du Terraform, pas un DSL.
- `terramate create --all-terragrunt` importe un repo Terragrunt existant, et l'orchestration suit les dépendances Terragrunt. La détection de changements suit les `include`, `dependency` et fichiers lus. Mon avis : ça dépanne, mais ce n'est pas terrible.
- Le changé, des deux côtés : Terragrunt fait un `git diff` entre deux worktrees temporaires (`--filter '[main...HEAD]'`, ou `--filter-affected`), dans la CLI open source (MIT). Récent, en 2026. Terramate le fait depuis longtemps, modules locaux compris.
- Une stack supprimée : Terragrunt la retrouve dans le diff et peut lancer un `plan -destroy` dans l'ancien worktree (`--filter-allow-destroy`). Terramate, non : on peut faire `--reverse` et `destroy` tant que le code est là, mais si on supprime le code de la stack, c'est trop tard. Il faut détruire avant de supprimer.
- Le payant chez Gruntwork : Terragrunt Scale (Pipelines, détection de drift, Patcher). Gratuit jusqu'à 25 unités, Team à partir de 500 $/mois en annuel (page lue en octobre 2026).
- Self-service, côté Terragrunt, deux outils :
  - `catalog` + `scaffold` (depuis la v0.54, décembre 2023) : une TUI pour parcourir les modules, et un `terragrunt.hcl` écrit une fois depuis un modèle boilerplate, avec des `TODO` à remplir. One-shot : le modèle évolue, les fichiers déjà créés non. Utile le premier jour, pas après.
  - Les stacks (`terragrunt.stack.hcl`, blocs `unit` avec `values`) : régénérées par `terragrunt stack generate`, donc vivantes comme un bundle. Mais pas de formulaire ni de prompt, et le code généré va dans `.terragrunt-stack/`, que la doc conseille d'ignorer dans git : on ne relit pas en MR ce qui tourne.
- Côté Terramate : un contrat typé, un formulaire (`terramate ui`), du code commité et relu. C'est là que Terramate est devant.
- Les liens, à l'avantage de Terragrunt : `dependency` lit les vrais outputs du state à l'exécution. Un export de bundle Terramate est calculé au `generate`, depuis les entrées : pas d'ID réel issu d'un `apply`. Pour ça, Terramate repasse par des `data` ou du remote state.
- Les mêmes infra et scénario existent en Terragrunt (`terramate/demo-terragrunt`), en Terraspace (`terramate/demo-terraspace`) et en Atmos (`terramate/demo-atmos`), pour comparer sur pièces. Chaque README a une section « Différences avec Terramate ».
- Mon avis : Terramate est plus fort pour reprendre un existant (on pose une stack sur chaque root module, sans rien réécrire), Terragrunt est plus confortable pour partir de zéro.
-->

---

<p class="eyebrow">L'autre question</p>
<h1>Et Terraspace ?</h1>

<div class="cols-code" style="margin-top:.6rem">
<div>
<p class="lbl">Ce qu'il fait bien</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="y">l'ordre, déduit des <code>output()</code></li>
<li class="y">les vrais outputs du state</li>
<li class="y">des tfvars par environnement</li>
</ul>
</div>
<div>
<p class="lbl">Ce qui manque</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="n">ne lancer que le changé</li>
<li class="n">le self-service</li>
<li class="n">relire le code généré</li>
</ul>
</div>
</div>

<p class="fixline">Un framework Ruby, peu actif : dernière version en octobre 2025.</p>

<p class="links"><a href="https://github.com/boltops-tools/terraspace">github.com/boltops-tools/terraspace</a> · <a href="https://terraspace.cloud/docs/">terraspace.cloud/docs</a></p>

<!--
Repères : un framework, pas un orchestrateur · il compile du Terraform à partir de templates ERB · bien pensé en 2020, peu de mouvement depuis

- Terraspace (BoltOps), une gem Ruby, Apache-2.0. Il compile chaque stack dans `.terraspace-cache/<env>/` : templates ERB, `config/terraform/` copié partout, tfvars en couches (`base`, `dev`, `prod`) choisies par `TS_ENV`.
- L'ordre : `terraspace all up` déduit le graphe des `output("zone.subnet_id")` écrits dans les tfvars, et déploie par lots. Comme Terragrunt, il lit les vrais outputs du state ; avant le premier déploiement, il faut des `mock:`.
- Ce qui manque, vu en démo : pas d'équivalent de `--changed` (un `all plan` planifie toutes les stacks), pas de tags, pas de catalogue ni de formulaire (une équipe = un copier-coller de dossiers), et le code généré est dans un cache ignoré par git : on ne relit pas en MR ce qui tourne.
- Installation : la gem dépend d'une extension C++ (`eventmachine`) : il faut un compilateur sur le poste ou dans l'image de CI. Pas un binaire unique.
- Activité : dernière version 2.2.20 le 13 octobre 2025, une dizaine de commits par an en 2024 et en 2025. Le dépôt n'est pas archivé.
- Il existe une offre Terraspace Cloud (dashboard, historique, droits). Je ne l'ai pas regardée.
- Démo complète : `terramate/demo-terraspace`, même infra, même scénario.
-->

---

<p class="eyebrow">Le plus proche</p>
<h1>Et Atmos ?</h1>

<div class="cols-code" style="margin-top:.6rem">
<div>
<p class="lbl">Ce qu'il fait bien</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="y">du YAML hiérarchique : imports, héritage</li>
<li class="y">les vrais outputs du state</li>
<li class="y">le changé, dépendants compris</li>
</ul>
</div>
<div>
<p class="lbl">Ce qui coince</p>
<ul class="yesno" style="font-size:1.1rem">
<li class="n">les modules, à déclarer à la main</li>
<li class="n">pas de plan avant le premier apply</li>
<li class="n">le backend généré, non relu</li>
</ul>
</div>
</div>

<p class="fixline">Le concurrent le plus complet, et très actif. Mais tout passe par du YAML.</p>

<p class="links"><a href="https://github.com/cloudposse/atmos">github.com/cloudposse/atmos</a> · <a href="https://atmos.tools/">atmos.tools</a></p>

<!--
Repères : Cloud Posse, Apache-2.0 · des composants (root modules) et des stacks en YAML · c'est le vrai concurrent de Terramate, celui qu'on vous citera

- Le modèle : des composants Terraform réutilisables, configurés par des stacks YAML. Imports, héritage, composants abstraits (`metadata.inherits`) : l'équivalent des globals et des bundles, en YAML.
- L'ordre : `dependencies.components` dans le YAML, et `atmos terraform apply --all -s prod` applique dans l'ordre (`--max-concurrency` pour paralléliser, 1 par défaut).
- Les liens : `!terraform.state zone-paris subnet_id` lit le vrai output dans le state, comme le `dependency` de Terragrunt. Revers : pas de mock, donc `plan --all` échoue tant que rien n'est appliqué.
- Le changé : `atmos describe affected --base main`, et `--include-dependents` pour remonter les composants qui en dépendent. Terramate a l'équivalent (`run --include-all-dependents`, 0.17.3), pas montré en démo. Mais un module local hors du dossier du composant n'est pas vu : il faut le déclarer (`dependencies.folders`). Terramate le suit tout seul.
- Le self-service : `atmos scaffold` (expérimental) pose des questions (`input`, `select`, `confirm`, validation) et écrit le YAML d'une équipe. Le YAML hérite ensuite du catalogue : il reste vivant, comme une instance de bundle. Pas de liens typés entre instances, pas de promotion.
- Comme Terragrunt, il compare dans un checkout git temporaire : avec un state local relatif, `describe affected` se trompe. Il faut un state distant (la démo utilise un chemin absolu).
- Activité : v1.232.0 le 13 octobre 2026, une version ou une release candidate tous les quelques jours en octobre 2026. Il fait aussi Helmfile, Packer, Ansible.
- Démo complète : `terramate/demo-atmos`, même infra, même scénario.
-->

---

<p class="eyebrow">À retenir</p>
<h1>Trois fois oui, à la carte</h1>

<div class="cards">
<div style="border-color:var(--accent)"><b>Orchestration</b><p>Découpez vos states. Terramate garde l'ordre et ne lance que ce qui a changé.</p></div>
<div style="border-color:var(--ochre)"><b>Génération</b><p>La plomberie s'écrit une fois. Le code généré est commité, donc relu.</p></div>
<div style="border-color:var(--brick)"><b>Self-service</b><p>Des bundles qui se demandent et se lient, sans portail à opérer. Jeune, mais prometteur.</p></div>
</div>

<p class="fixline">On commence par <code>terramate create --all-terraform</code> et <code>run --changed</code>. Le reste vient quand on en a besoin.</p>

<!--
Repères : on n'adopte pas tout d'un coup · orchestration d'abord, c'est le plus gros gain · génération ensuite · les bundles quand le nombre d'équipes le justifie

**Mon avis, à l'oral uniquement (pas à l'écran).** Proposition à reformuler avec tes mots :

- **Ce que j'aime**
  - Il n'enveloppe pas Terraform : le code reste standard, on peut sortir de Terramate du jour au lendemain (le code généré est commité, il suffit de supprimer les `.tm.hcl`).
  - La détection de changements par git, modules compris : c'est ce qui rend une CI mono-repo supportable. Chez Additi, c'est ce qui fait tourner tout le SI Scaleway, et la rotation des clés par tags.
  - Un binaire Go, rien à opérer, adoption progressive.
  - Les garde-fous : ce qui tourne, c'est ce qui est commité.
- **Ce qui me gêne**
  - Des briques importantes restent expérimentales (les scripts, le partage d'outputs) : on construit sa CI sur des `experiments`.
  - Le code généré fait du bruit dans les MR et l'héritage des globals devient opaque sur une grosse arborescence (`debug show globals` obligatoire).
  - Les bundles sont jeunes : en préparant la démo, je suis tombé sur un bug en 0.17.3 (l'ordre des tags d'une stack créée par un bundle change entre deux `generate`, et le garde-fou bloque le `run`). Les versions 0.x cassent la compatibilité entre mineures.
- **En une phrase** : pour un mono-repo Terraform avec beaucoup de stacks, c'est aujourd'hui l'outil que je recommande ; pour les bundles, j'attendrais un peu avant de le mettre devant toutes les équipes.
-->

---

<p class="eyebrow">Pour aller plus loin</p>
<h1>Les outils, leurs docs, les démos</h1>

<table class="map">
<thead><tr><th></th><th>Code</th><th>Documentation</th><th>Démo dans le repo</th></tr></thead>
<tbody>
<tr><td><b>Terramate</b></td><td><a href="https://github.com/terramate-io/terramate">github.com/terramate-io/terramate</a></td><td><a href="https://terramate.io/docs/">terramate.io/docs</a></td><td><code>terramate/demo</code></td></tr>
<tr><td><b>Terragrunt</b></td><td><a href="https://github.com/gruntwork-io/terragrunt">github.com/gruntwork-io/terragrunt</a></td><td><a href="https://docs.terragrunt.com/">docs.terragrunt.com</a></td><td><code>terramate/demo-terragrunt</code></td></tr>
<tr><td><b>Terraspace</b></td><td><a href="https://github.com/boltops-tools/terraspace">github.com/boltops-tools/terraspace</a></td><td><a href="https://terraspace.cloud/docs/">terraspace.cloud/docs</a></td><td><code>terramate/demo-terraspace</code></td></tr>
<tr><td><b>Atmos</b></td><td><a href="https://github.com/cloudposse/atmos">github.com/cloudposse/atmos</a></td><td><a href="https://atmos.tools/">atmos.tools</a></td><td><code>terramate/demo-atmos</code></td></tr>
<tr><td><b>OpenTofu</b></td><td><a href="https://github.com/opentofu/opentofu">github.com/opentofu/opentofu</a></td><td><a href="https://opentofu.org/docs/">opentofu.org/docs</a></td><td></td></tr>
<tr><td><b>Terraform</b></td><td><a href="https://github.com/hashicorp/terraform">github.com/hashicorp/terraform</a></td><td><a href="https://developer.hashicorp.com/terraform/docs">developer.hashicorp.com/terraform/docs</a></td><td></td></tr>
</tbody>
</table>

<p class="fixline">Les quatre démos : même infra, même scénario, hors ligne. <a href="https://github.com/Wihrt/talks">github.com/Wihrt/talks</a></p>

<!--
Repères : à laisser affichée pendant les questions · tout est dans le repo du talk

- Chaque démo a un `prepare.sh` et un README avec le scénario et une section « Différences avec Terramate », tirée des tests.
- Versions testées : Terramate 0.17.3, Terragrunt 1.1.6, Terraspace 2.2.20 (Ruby 3.3), Atmos 1.232.0, OpenTofu 1.10.
-->

---
layout: center
class: text-center
---

<h1>Merci !</h1>
<p class="muted">Le code de la démo est dans le repo du talk.</p>
<p>Questions ?</p>

<div style="display:flex;gap:1.2rem;align-items:center;justify-content:center;margin-top:1.5rem">
<div style="background:#fff;border:1px solid var(--line);border-radius:10px;padding:.8rem"><svg viewBox="0 0 29 29" role="img" aria-label="QR code vers le support du talk" style="width:9rem;height:9rem;display:block"><path stroke="#1f1830" d="M0 0.5h7M8 0.5h3M13 0.5h2M18 0.5h1M22 0.5h7M0 1.5h1M6 1.5h1M9 1.5h4M16 1.5h3M20 1.5h1M22 1.5h1M28 1.5h1M0 2.5h1M2 2.5h3M6 2.5h1M8 2.5h1M10 2.5h4M15 2.5h1M17 2.5h1M19 2.5h2M22 2.5h1M24 2.5h3M28 2.5h1M0 3.5h1M2 3.5h3M6 3.5h1M9 3.5h2M13 3.5h3M17 3.5h1M19 3.5h1M22 3.5h1M24 3.5h3M28 3.5h1M0 4.5h1M2 4.5h3M6 4.5h1M10 4.5h4M18 4.5h1M22 4.5h1M24 4.5h3M28 4.5h1M0 5.5h1M6 5.5h1M8 5.5h3M12 5.5h1M14 5.5h1M16 5.5h3M22 5.5h1M28 5.5h1M0 6.5h7M8 6.5h1M10 6.5h1M12 6.5h1M14 6.5h1M16 6.5h1M18 6.5h1M20 6.5h1M22 6.5h7M10 7.5h1M18 7.5h3M0 8.5h1M2 8.5h1M6 8.5h2M9 8.5h2M15 8.5h2M20 8.5h1M23 8.5h1M26 8.5h1M28 8.5h1M1 9.5h4M12 9.5h1M15 9.5h2M18 9.5h2M21 9.5h3M27 9.5h2M0 10.5h1M2 10.5h1M6 10.5h1M8 10.5h3M13 10.5h1M15 10.5h3M19 10.5h2M22 10.5h2M25 10.5h2M28 10.5h1M5 11.5h1M7 11.5h2M10 11.5h1M14 11.5h2M19 11.5h1M25 11.5h1M0 12.5h4M5 12.5h4M11 12.5h1M14 12.5h2M19 12.5h4M28 12.5h1M1 13.5h2M4 13.5h1M9 13.5h3M13 13.5h1M15 13.5h2M19 13.5h2M22 13.5h2M27 13.5h2M4 14.5h1M6 14.5h2M15 14.5h5M23 14.5h2M28 14.5h1M4 15.5h1M8 15.5h3M12 15.5h1M14 15.5h2M18 15.5h1M20 15.5h1M22 15.5h1M24 15.5h1M1 16.5h2M4 16.5h7M13 16.5h3M19 16.5h1M22 16.5h2M28 16.5h1M1 17.5h1M3 17.5h1M7 17.5h2M10 17.5h1M15 17.5h3M19 17.5h2M22 17.5h2M26 17.5h3M0 18.5h3M4 18.5h3M8 18.5h1M13 18.5h3M17 18.5h1M19 18.5h2M22 18.5h1M24 18.5h2M28 18.5h1M2 19.5h1M4 19.5h1M7 19.5h6M16 19.5h1M21 19.5h2M24 19.5h1M0 20.5h3M6 20.5h2M9 20.5h2M13 20.5h4M20 20.5h6M27 20.5h1M8 21.5h1M12 21.5h2M15 21.5h3M20 21.5h1M24 21.5h3M28 21.5h1M0 22.5h7M8 22.5h2M11 22.5h2M15 22.5h2M18 22.5h1M20 22.5h1M22 22.5h1M24 22.5h1M28 22.5h1M0 23.5h1M6 23.5h1M12 23.5h2M16 23.5h1M18 23.5h3M24 23.5h1M0 24.5h1M2 24.5h3M6 24.5h1M9 24.5h1M11 24.5h3M15 24.5h1M19 24.5h7M27 24.5h1M0 25.5h1M2 25.5h3M6 25.5h1M9 25.5h1M11 25.5h1M15 25.5h2M18 25.5h1M21 25.5h1M24 25.5h3M28 25.5h1M0 26.5h1M2 26.5h3M6 26.5h1M8 26.5h2M14 26.5h2M18 26.5h1M20 26.5h2M24 26.5h1M27 26.5h2M0 27.5h1M6 27.5h1M9 27.5h2M13 27.5h4M18 27.5h3M22 27.5h4M0 28.5h7M8 28.5h2M11 28.5h4M16 28.5h1M18 28.5h1M20 28.5h1M22 28.5h1M24 28.5h1M28 28.5h1"/></svg></div>
<p class="muted" style="margin:0;text-align:left;font-family:Archivo,sans-serif">Le support et la démo :<br><b style="color:var(--accent)">wihrt.github.io/talks/terramate</b></p>
</div>

<!--
**Questions probables**
- « On peut passer des outputs d'une stack à l'autre ? » → oui, l'output sharing (blocs `output`/`input`, `run --enable-sharing`), mais c'est encore à part. Sinon : data sources ou remote state.
- « Et Atlantis / Spacelift / env0 ? » → ce sont des plateformes d'exécution. Terramate CLI tourne dans la CI qu'on a déjà ; on peut même combiner.
- « Le code généré, on le commite vraiment ? » → oui, c'est voulu : on relit ce qui tourne, et on peut sortir de Terramate sans rien casser.
- « Les bundles, c'est payant ? » → non : depuis la 0.16, bundles, composants et `terramate ui` sont dans la CLI open source (MPL-2.0). Encore marqué bêta.
- « Et Terramate Cloud ? » → je ne l'ai jamais utilisé, je ne peux pas en parler. Tout ce qu'on a vu tourne avec la CLI open source seule.
- « Ça marche avec OpenTofu ? » → oui, la démo tourne sur OpenTofu.
-->
