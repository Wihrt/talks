---
theme: default
routerMode: hash
title: "Terramate : orchestrer, générer, industrialiser son Terraform"
info: |
  Ce que résout Terramate quand Terraform passe à l'échelle : orchestration et détection de changements, génération de code, platform engineering avec Catalyst. Avec une démo.
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

<p class="eyebrow">Le point de départ</p>
<h1>Un root module, un state, tout le SI</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:19rem" viewBox="0 0 760 280" role="img" aria-label="Un seul root module contient le réseau, Kubernetes, les bases et les applications de toutes les équipes, avec un seul state : le plan prend des minutes, un seul verrou bloque tout le monde, et une erreur peut toucher tout le SI."><defs><marker id="mo-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-box" x="20" y="20" width="400" height="240" rx="6" style="stroke-dasharray:6 5"></rect><text class="s-title" x="220" y="44" text-anchor="middle">un root module : infra/</text><rect class="s-box" x="40" y="62" width="110" height="40" rx="4"></rect><text class="s-lbl" x="95" y="87" text-anchor="middle">réseau</text><rect class="s-box" x="165" y="62" width="110" height="40" rx="4"></rect><text class="s-lbl" x="220" y="87" text-anchor="middle">Kubernetes</text><rect class="s-box" x="290" y="62" width="110" height="40" rx="4"></rect><text class="s-lbl" x="345" y="87" text-anchor="middle">IAM</text><rect class="s-box" x="40" y="114" width="110" height="40" rx="4"></rect><text class="s-lbl" x="95" y="139" text-anchor="middle">bases équipe A</text><rect class="s-box" x="165" y="114" width="110" height="40" rx="4"></rect><text class="s-lbl" x="220" y="139" text-anchor="middle">bases équipe B</text><rect class="s-box" x="290" y="114" width="110" height="40" rx="4"></rect><text class="s-lbl" x="345" y="139" text-anchor="middle">buckets</text><rect class="s-box" x="40" y="166" width="110" height="40" rx="4"></rect><text class="s-lbl" x="95" y="191" text-anchor="middle">DNS</text><rect class="s-box" x="165" y="166" width="110" height="40" rx="4"></rect><text class="s-lbl" x="220" y="191" text-anchor="middle">secrets</text><rect class="s-box" x="290" y="166" width="110" height="40" rx="4"></rect><text class="s-lbl" x="345" y="191" text-anchor="middle">…</text><text class="s-txt" x="220" y="236" text-anchor="middle">des milliers de ressources</text><line class="s-line" x1="422" y1="140" x2="486" y2="140" marker-end="url(#mo-a)"></line><rect class="s-badbox" x="490" y="110" width="110" height="60" rx="6"></rect><text class="s-title" x="545" y="137" text-anchor="middle">1 state</text><text class="s-txt" x="545" y="155" text-anchor="middle">1 verrou</text><text class="s-lbl-bad" x="620" y="60">plan : plusieurs minutes</text><text class="s-lbl-bad" x="620" y="78">rate limits des API</text><text class="s-lbl-bad" x="620" y="138">une équipe applique,</text><text class="s-lbl-bad" x="620" y="156">les autres attendent</text><text class="s-lbl-bad" x="620" y="214">une erreur = tout</text><text class="s-lbl-bad" x="620" y="232">le SI touché</text></svg></div>

<p class="fixline">Le réflexe : découper en plusieurs root modules, chacun son state.</p>

<!--
**⏱ Le problème : ~5 min**

Repères : tout le monde a commencé comme ça · ça marche, jusqu'au jour où ça ne marche plus · trois douleurs : lenteur, verrou, blast radius

- Lenteur : chaque plan rafraîchit toutes les ressources. Des centaines d'appels API, des rate limits, des minutes.
- Verrou : un seul state, un seul lock. Deux personnes ne peuvent pas appliquer en même temps, même sur des sujets sans rapport.
- Blast radius : un `apply` sur le DNS peut, par erreur, toucher une base. Et les droits de la CI couvrent tout.
- La réponse classique, et la bonne : découper. Un root module par périmètre, chacun son state.
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
- L'ordre : Terraform gère les dépendances DANS un root module, pas ENTRE root modules.
- Quoi lancer : sans détection de changements, la CI planifie tout, ou un humain choisit. Les deux sont mauvais.
- Self-service : c'est la partie platform engineering, on y vient avec Catalyst.
-->

---

<p class="eyebrow">Terramate</p>
<h1>Un binaire, trois piliers</h1>

<div class="pillars">
<div style="--c:var(--accent)"><h3>Orchestration</h3><p>Des <b>stacks</b>, un ordre, la détection de changements par git. <code>terramate run</code> lance n'importe quelle commande, dans le bon ordre, seulement là où ça a changé.</p></div>
<div style="--c:var(--ochre)"><h3>Génération de code</h3><p>Des <b>globals</b> hérités et des <code>generate_hcl</code> : le code répétitif est écrit une fois, généré partout, et commité.</p></div>
<div style="--c:var(--brick)"><h3>Catalyst</h3><p>Des <b>composants</b> et des <b>bundles</b> : la plateforme publie un catalogue, les équipes l'instancient en quelques lignes de YAML.</p></div>
</div>

<p class="fixline">CLI open source (MPL-2.0), écrite en Go. Terraform, OpenTofu et Terragrunt. Les fichiers <code>.tf</code> restent du Terraform pur.</p>

<!--
Repères : un binaire Go, rien à installer côté runtime · trois piliers, qu'on prend à la carte · on peut adopter Terramate sur un repo existant sans réécrire une ligne de Terraform

- Différence clé avec Terragrunt : Terramate n'enveloppe pas Terraform. Il ne réécrit pas la commande, il ne remplace pas `terraform`. On lance `terramate run -- terraform plan`, ou `tofu`, ou `tflint`, ou n'importe quoi.
- Le code généré est commité dans le repo : ce qui est relu en MR, c'est ce qui tourne. Pas de génération cachée à l'exécution.
- Version utilisée pour ce talk : 0.17.3.
-->

---
layout: section
---

<p class="eyebrow">Pilier 1</p>
<h1>Orchestration</h1>

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

<p class="eyebrow">Pilier 2</p>
<h1>Génération de code</h1>

<!--
**⏱ Génération : ~6 min**
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
      required_version = global.tofu_version

      backend "s3" {
        bucket = "${global.organisation}-tfstate"
        region = global.region
        key    = "${terramate.stack.path.relative}/terraform.tfstate"
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
  required_version = "~> 1.10"
  backend "s3" {
    bucket = "demo-tfstate"
    region = "fr-par"
    key    = "stacks/socle/kubernetes/terraform.tfstate"
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

<p class="eyebrow">La boîte à outils</p>
<h1>Générer juste ce qu'il faut, là où il faut</h1>

<div class="mini">
<div><b><code>generate_hcl</code> · <code>generate_file</code></b><p>Du HCL validé et formaté, ou n'importe quel fichier : JSON, YAML, un <code>.tflint.hcl</code>…</p></div>
<div><b><code>condition</code> · <code>stack_filter</code></b><p>Générer seulement pour certaines stacks : un tag, un chemin, une valeur de global.</p></div>
<div><b><code>tm_dynamic</code> · <code>lets</code> · <code>tm_*</code></b><p>Blocs dynamiques, valeurs locales, et les fonctions Terraform préfixées : <code>tm_join</code>, <code>tm_try</code>…</p></div>
<div><b><code>import</code></b><p>Partager des générateurs entre dossiers, ou entre repos : une bibliothèque de conventions.</p></div>
</div>

```hcl
generate_hcl "_provider_kubernetes.tf" {
  condition = tm_contains(terramate.stack.tags, "kubernetes")
  content {
    provider "kubernetes" { config_path = "~/.kube/${global.environnement}" }
  }
}
```

<!--
Repères : quatre outils, pas plus · le provider Kubernetes seulement là où il sert

- `generate_hcl` produit du HCL vérifié : une erreur de syntaxe casse le `generate`, pas l'`apply`.
- `generate_file` pour tout le reste.
- `condition` évalue par stack ; `stack_filter` filtre par chemin, plus simple à lire.
- La limite : c'est puissant, donc on peut en faire trop. Mon conseil : générer le plomberie (backend, providers, versions), pas la logique métier. La logique, ça reste des modules Terraform.
-->

---
layout: section
---

<p class="eyebrow">Pilier 3</p>
<h1>Catalyst</h1>

<!--
**⏱ Catalyst : ~7 min**
-->

---

<p class="eyebrow">Platform engineering</p>
<h1>Les équipes ne devraient pas écrire de HCL</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:17rem" viewBox="0 0 760 250" role="img" aria-label="L&#x27;équipe plateforme écrit des composants, des briques Terraform, et les assemble en bundles. Une équipe produit instancie un bundle avec quelques lignes de YAML. terramate generate en tire les stacks et le code, que terramate run déploie."><defs><marker id="ca-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><text class="s-title" x="20" y="22">Équipe plateforme</text><rect class="s-zone" x="10" y="32" width="390" height="120" rx="8"></rect><rect class="s-box" x="25" y="50" width="150" height="38" rx="5"></rect><text class="s-lbl" x="100" y="74" text-anchor="middle">composant · bucket</text><rect class="s-box" x="25" y="100" width="150" height="38" rx="5"></rect><text class="s-lbl" x="100" y="124" text-anchor="middle">composant · base</text><line class="s-line" x1="177" y1="69" x2="226" y2="88" marker-end="url(#ca-a)"></line><line class="s-line" x1="177" y1="119" x2="226" y2="102" marker-end="url(#ca-a)"></line><rect class="s-hub" x="230" y="66" width="155" height="56" rx="6"></rect><text class="s-title" x="307" y="90" text-anchor="middle">bundle</text><text class="s-txt" x="307" y="108" text-anchor="middle">« espace d'équipe »</text><text class="s-title" x="20" y="190">Équipe produit</text><rect class="s-okbox" x="25" y="200" width="200" height="40" rx="5"></rect><text class="s-lbl" x="125" y="225" text-anchor="middle">paiement.tm.yml · 10 lignes</text><line class="s-line" x1="227" y1="215" x2="300" y2="128" marker-end="url(#ca-a)" style="stroke-dasharray:4 4"></line><text class="s-lbl" x="268" y="188">instancie</text><line class="s-line" x1="387" y1="94" x2="456" y2="94" marker-end="url(#ca-a)"></line><rect class="s-box" x="460" y="60" width="140" height="68" rx="6"></rect><text class="s-title" x="530" y="88" text-anchor="middle">terramate</text><text class="s-title" x="530" y="106" text-anchor="middle">generate</text><line class="s-line" x1="602" y1="94" x2="636" y2="94" marker-end="url(#ca-a)"></line><rect class="s-box" x="640" y="44" width="110" height="34" rx="5"></rect><text class="s-lbl" x="695" y="66" text-anchor="middle">stack stockage</text><rect class="s-box" x="640" y="110" width="110" height="34" rx="5"></rect><text class="s-lbl" x="695" y="132" text-anchor="middle">stack base</text><text class="s-txt" x="695" y="170" text-anchor="middle">+ le code, commité</text></svg></div>

<p class="fixline">La plateforme publie un catalogue. Les équipes le consomment, sans connaître Terraform.</p>

<!--
Repères : Catalyst = le volet platform engineering · d'abord un binaire à part en bêta privée (fin 2025), fusionné dans la CLI open source en 0.16 (février 2026) · encore marqué bêta dans la doc · composant, bundle, instance

- Avant Catalyst : on faisait ça avec des modules Terraform et de la génération. Ça marche, mais l'équipe produit écrit quand même du HCL, et connaît la structure du repo.
- Avec Catalyst, trois niveaux :
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

<p class="eyebrow">Ce qu'écrit une équipe</p>
<h1>10 lignes de YAML</h1>

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
**⏱ Démo : ~10 min.** Scénario complet et commandes : `terramate/demo/README.md`.

Préparation : `./terramate/demo/prepare.sh /tmp/terramate-demo`, terminal en gros caractères, thème clair. Garder un second terminal où la démo est déjà jouée jusqu'à l'étape 5 (plan B).
-->

---

<p class="eyebrow">Démo · le programme</p>
<h1>Un socle, deux équipes, zéro cloud</h1>

<div class="steps">
<span class="n">1</span><b>Les stacks et l'ordre</b><span><code>terramate list --run-order</code></span>
<span class="n">2</span><b>La génération</b><span><code>terramate generate</code>, et le premier garde-fou</span>
<span class="n">3</span><b>L'orchestration</b><span><code>run --parallel</code>, <code>script run</code>, <code>--tags</code></span>
<span class="n">4</span><b>La détection</b><span>une branche, un module, <code>list --changed --why</code></span>
<span class="n">5</span><b>Catalyst</b><span>une nouvelle équipe avec <code>terramate ui</code>, puis <code>run --changed</code></span>
</div>

<p class="fixline">OpenTofu, des <code>terraform_data</code>, un backend local : tout tourne hors ligne.</p>

<!--
Repères : annoncer les 5 étapes, puis basculer sur le terminal · revenir sur cette slide entre les étapes si besoin

1. `terramate list --run-order` : reseau, puis kubernetes. Pas encore d'équipe : les stacks du bundle naissent au `generate`.
2. `terramate generate`, montrer `_terramate_backend.tf`, relancer `list --run-order` : les stacks de paiement sont là, à leur place. Lancer `terramate run -- tofu init` : refusé, fichiers non commités. Commit, relancer.
3. `terramate run --parallel 4 -- tofu apply -auto-approve`, puis `terramate script run deploiement`, puis `terramate list --tags socle`.
4. Branche `montee-k8s`, passer 1.34 en 1.35, commit, `terramate list --changed --why` : une stack. Puis une modif du module : la stack qui l'appelle, avec la raison.
5. Branche `equipe-catalogue`, `terramate ui` (ou le sed du README), `terramate generate`, commit, `terramate list --changed` : seulement les stacks de la nouvelle équipe. `run --changed -- tofu apply`.

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

<table class="map">
<thead><tr><th></th><th>Terragrunt</th><th>Terramate</th></tr></thead>
<tbody>
<tr><td>Rapport à Terraform</td><td>l'enveloppe : <code>terragrunt plan</code></td><td>le lance : <code>terramate run -- tofu plan</code></td></tr>
<tr><td>Le code</td><td><code>terragrunt.hcl</code> + modules, résolu à l'exécution</td><td>Terraform pur + code généré, commité</td></tr>
<tr><td>Ordre entre unités</td><td><code>dependency</code>, avec passage d'outputs</td><td><code>after</code> / <code>before</code>, sans passage d'outputs</td></tr>
<tr><td>Ne lancer que le changé</td><td>à outiller (filtres, scripts)</td><td>natif, par git, modules compris</td></tr>
<tr><td>Self-service</td><td>non</td><td>Catalyst</td></tr>
<tr><td>Adoption</td><td>restructurer le repo</td><td><code>create --all-terraform</code></td></tr>
</tbody>
</table>

<p class="fixline">Et ils cohabitent : Terramate sait orchestrer un repo Terragrunt.</p>

<!--
Repères : pas une guerre de religion · deux philosophies : envelopper vs orchestrer · on peut combiner

- Le vrai point fort de Terragrunt : `dependency` qui passe les outputs d'une unité à l'autre. Chez Terramate, l'équivalent (output sharing) existe mais reste à part ; on fait souvent avec des data sources ou du remote state.
- Le vrai point fort de Terramate : la détection par git, et le fait que le code reste du Terraform standard. Un nouvel arrivant lit du Terraform, pas un DSL.
- `terramate create --all-terragrunt` importe un repo Terragrunt existant, et l'orchestration suit les dépendances Terragrunt.
-->

---

<p class="eyebrow">À retenir</p>
<h1>Trois piliers, à la carte</h1>

<div class="cards">
<div style="border-color:var(--accent)"><b>Orchestration</b><p>Découpez vos states. Terramate garde l'ordre et ne lance que ce qui a changé.</p></div>
<div style="border-color:var(--ochre)"><b>Génération</b><p>La plomberie s'écrit une fois. Le code généré est commité, donc relu.</p></div>
<div style="border-color:var(--brick)"><b>Catalyst</b><p>Un catalogue pour les équipes, sans portail à opérer. Jeune, mais prometteur.</p></div>
</div>

<p class="fixline">On commence par <code>terramate create --all-terraform</code> et <code>run --changed</code>. Le reste vient quand on en a besoin.</p>

<!--
Repères : on n'adopte pas tout d'un coup · orchestration d'abord, c'est le plus gros gain · génération ensuite · Catalyst quand le nombre d'équipes le justifie

**Mon avis, à l'oral uniquement (pas à l'écran).** Proposition à reformuler avec tes mots :

- **Ce que j'aime**
  - Il n'enveloppe pas Terraform : le code reste standard, on peut sortir de Terramate du jour au lendemain (le code généré est commité, il suffit de supprimer les `.tm.hcl`).
  - La détection de changements par git, modules compris : c'est ce qui rend une CI mono-repo supportable. Chez Additi, c'est ce qui fait tourner tout le SI Scaleway, et la rotation des clés par tags.
  - Un binaire Go, rien à opérer, adoption progressive.
  - Les garde-fous : ce qui tourne, c'est ce qui est commité.
- **Ce qui me gêne**
  - Des briques importantes restent expérimentales (les scripts, le partage d'outputs) : on construit sa CI sur des `experiments`.
  - Le code généré fait du bruit dans les MR et l'héritage des globals devient opaque sur une grosse arborescence (`debug show globals` obligatoire).
  - Catalyst est jeune : en préparant la démo, je suis tombé sur un bug en 0.17.3 (l'ordre des tags d'une stack créée par un bundle change entre deux `generate`, et le garde-fou bloque le `run`). Les versions 0.x cassent la compatibilité entre mineures.
- **En une phrase** : pour un mono-repo Terraform avec beaucoup de stacks, c'est aujourd'hui l'outil que je recommande ; pour Catalyst, j'attendrais un peu avant de le mettre devant toutes les équipes.
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
- « Catalyst, c'est payant ? » → non : depuis la 0.16, bundles, composants et `terramate ui` sont dans la CLI open source (MPL-2.0). Encore marqué bêta.
- « Et Terramate Cloud ? » → je ne l'ai jamais utilisé, je ne peux pas en parler. Tout ce qu'on a vu tourne avec la CLI open source seule.
- « Ça marche avec OpenTofu ? » → oui, la démo tourne sur OpenTofu.
-->
