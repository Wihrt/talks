---
theme: default
routerMode: hash
title: "Une randonnée pas si tranquille : migrer sur Scaleway"
info: |
  REX de la migration du SI d'Additi de GCP vers Scaleway : les points mineurs, majeurs et bloquants rencontrés, et comment on les a gérés.
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

<p class="eyebrow">REX · meetup</p>
<h1>Une randonnée pas si tranquille</h1>
<h2>Migrer sur Scaleway</h2>
<p class="muted" style="margin-top:2rem">Arnaud Hatzenbuhler · Platform Engineer / Expert DevOps, OBS</p>

<!--
**⏱ Ouverture : ~5 min (slides 1 à 5)**

Repères : titre · bonne soirée · on passe à moi
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

Repères : à dire, pas à écrire : OBS aujourd'hui · la migration, c'était chez Additi · équipe infra de 3
-->

---

<p class="eyebrow">Le contexte</p>
<h1>Pourquoi on part : un cloud souverain</h1>

<div class="diagram-wrap"><svg class="diagram" viewBox="0 0 760 290" role="img" aria-label="Additi migre de GCP vers Scaleway, cloud souverain ; c&#x27;est tout le SI qui part : les équipes métier et le socle infra."><defs><marker id="c-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-box" x="40" y="30" width="220" height="90" rx="6"></rect><text class="s-big" x="150" y="72" text-anchor="middle">GCP</text><text class="s-txt" x="150" y="96" text-anchor="middle">aujourd'hui</text><rect class="s-hub" x="500" y="30" width="220" height="90" rx="6"></rect><text class="s-big" x="610" y="72" text-anchor="middle">Scaleway</text><text class="s-txt" x="610" y="96" text-anchor="middle">cloud souverain</text><line class="s-line" x1="262" y1="75" x2="496" y2="75" marker-end="url(#c-a)"></line><text class="s-lbl" x="379" y="64" text-anchor="middle">migration actée</text><text class="s-txt" x="379" y="94" text-anchor="middle">après comparatif de providers</text><rect class="s-box" x="40" y="165" width="680" height="110" rx="6" style="stroke-dasharray:6 5"></rect><text class="s-title" x="380" y="188" text-anchor="middle">Tout le SI d'Additi</text><rect class="s-box" x="60" y="205" width="115" height="48" rx="5"></rect><text class="s-lbl" x="117" y="234" text-anchor="middle">équipe A</text><rect class="s-box" x="190" y="205" width="115" height="48" rx="5"></rect><text class="s-lbl" x="247" y="234" text-anchor="middle">équipe B</text><rect class="s-box" x="320" y="205" width="115" height="48" rx="5"></rect><text class="s-lbl" x="377" y="234" text-anchor="middle">équipe C</text><rect class="s-box" x="450" y="205" width="115" height="48" rx="5"></rect><text class="s-lbl" x="507" y="234" text-anchor="middle">…</text><rect class="s-hub" x="580" y="205" width="120" height="48" rx="5"></rect><text class="s-lbl" x="640" y="234" text-anchor="middle">socle infra</text><line class="s-line" x1="610" y1="163" x2="610" y2="124" marker-end="url(#c-a)"></line></svg></div>

<p class="fixline">Ce n'est pas un morceau qui part : c'est tout le SI d'Additi.</p>

<!--
Repères : Additi sur GCP · décision : cloud souverain · comparatif, Scaleway retenu · tout le SI, pas un pilote

- **Rester sur la souveraineté.** Pas d'allusion politique ni à une personne : ça détourne l'attention, et la slide n'en a pas besoin.
- Point clé : c'est TOUT le système d'information qui migre, pas un projet pilote.
- Périmètre : 3 zones parisiennes, Kapsule, RDB, Object Storage, Secret Manager, IAM, Load Balancer, Cockpit, VPN site-à-site. Juillet à octobre 2026.

*Pour moi, pas à l'écran :* l'opération est aussi favorable financièrement. Si la question vient : « le coût a joué, mais le moteur, c'est la souveraineté ». **Ne jamais citer les conditions du contrat.**
-->

---

<p class="eyebrow">L'architecture</p>
<h1>Hub-and-spoke, isolation forte</h1>

<div class="diagram-wrap"><svg class="diagram" style="max-height:18rem" viewBox="0 0 760 390" role="img" aria-label="Le hub héberge Grafana et les backends d&#x27;observabilité, ArgoCD et Harbor ; il déploie dans trois spokes, un par équipe métier ; les collecteurs des spokes renvoient logs, métriques et traces au hub ; aucun flux entre spokes."><defs><marker id="hs-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="hs-t" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker></defs><rect class="s-hub" x="250" y="16" width="260" height="96" rx="6"></rect><text class="s-title" x="380" y="40" text-anchor="middle">Hub · solutions centrales</text><text class="s-txt" x="380" y="60" text-anchor="middle">Grafana, backends d'observabilité</text><text class="s-txt" x="380" y="78" text-anchor="middle">ArgoCD · Harbor</text><text class="s-txt" x="380" y="96" text-anchor="middle">porte la sécurité de l'ensemble</text><line class="s-line" x1="312" y1="112" x2="108" y2="236" marker-end="url(#hs-a)"></line><line class="s-ok" x1="132" y1="238" x2="336" y2="114" marker-end="url(#hs-t)"></line><line class="s-line" x1="372" y1="112" x2="372" y2="236" marker-end="url(#hs-a)"></line><line class="s-ok" x1="388" y1="238" x2="388" y2="114" marker-end="url(#hs-t)"></line><line class="s-line" x1="424" y1="112" x2="628" y2="236" marker-end="url(#hs-a)"></line><line class="s-ok" x1="652" y1="238" x2="448" y2="114" marker-end="url(#hs-t)"></line><text class="s-lbl" x="196" y="150" text-anchor="end">ArgoCD déploie,</text><text class="s-lbl" x="196" y="165" text-anchor="end">via l'API Kapsule publique</text><text class="s-lbl-ok" x="566" y="150">logs, métriques, traces</text><text class="s-lbl-ok" x="566" y="165">vers les backends du hub</text><rect class="s-box" x="20" y="240" width="200" height="130" rx="6"></rect><text class="s-title" x="120" y="264" text-anchor="middle">Spoke · équipe A</text><text class="s-txt" x="120" y="288" text-anchor="middle">projet = frontière IAM</text><text class="s-txt" x="120" y="306" text-anchor="middle">VPC isolé = frontière réseau</text><text class="s-txt" x="120" y="324" text-anchor="middle">Kapsule : applis + collecteurs</text><text class="s-txt" x="120" y="342" text-anchor="middle">RDB · buckets · secrets</text><rect class="s-box" x="280" y="240" width="200" height="130" rx="6"></rect><text class="s-title" x="380" y="264" text-anchor="middle">Spoke · équipe B</text><text class="s-txt" x="380" y="288" text-anchor="middle">projet = frontière IAM</text><text class="s-txt" x="380" y="306" text-anchor="middle">VPC isolé = frontière réseau</text><text class="s-txt" x="380" y="324" text-anchor="middle">Kapsule : applis + collecteurs</text><text class="s-txt" x="380" y="342" text-anchor="middle">RDB · buckets · secrets</text><rect class="s-box" x="540" y="240" width="200" height="130" rx="6"></rect><text class="s-title" x="640" y="264" text-anchor="middle">Spoke · équipe C</text><text class="s-txt" x="640" y="288" text-anchor="middle">projet = frontière IAM</text><text class="s-txt" x="640" y="306" text-anchor="middle">VPC isolé = frontière réseau</text><text class="s-txt" x="640" y="324" text-anchor="middle">Kapsule : applis + collecteurs</text><text class="s-txt" x="640" y="342" text-anchor="middle">RDB · buckets · secrets</text><line class="s-no" x1="222" y1="305" x2="278" y2="305"></line><line class="s-no" x1="482" y1="305" x2="538" y2="305"></line><text class="s-lbl-bad" x="250" y="296" text-anchor="middle">aucun</text><text class="s-lbl-bad" x="250" y="321" text-anchor="middle">flux</text><text class="s-lbl-bad" x="510" y="296" text-anchor="middle">aucun</text><text class="s-lbl-bad" x="510" y="321" text-anchor="middle">flux</text></svg></div>

<p class="fixline">Partout, uniquement du Kubernetes : on ne fait que du Kube.</p>

<!--
- Plusieurs équipes, des domaines métier distincts, sans adhérence : chacune peut vivre seule.
- Hub-and-spoke avec isolation forte (réseau, IAM) : chacun n'accède qu'à ce dont il a besoin. La sécurité est portée par l'infra.
- **Le hub** héberge les solutions centrales : ArgoCD, Harbor, et toute notre stack d'observabilité (Grafana et ses backends).
- **Chaque spoke** porte les workloads applicatifs et les collecteurs (logs, métriques, traces), qui remontent tout au hub.
- Les spokes ne se parlent pas.
-->

---

<p class="eyebrow">Avant de translater</p>
<h1>Ce qui existe, des deux côtés</h1>

<div class="grid grid-cols-2 gap-8 mt-2">
<table class="map">
<thead><tr><th>Brique</th><th>GCP</th><th>Scaleway</th></tr></thead>
<tbody>
<tr><td>Kubernetes managé</td><td>✓</td><td>✓ <small>Kapsule</small></td></tr>
<tr><td>PostgreSQL, MySQL managés</td><td>✓</td><td>✓ <small>PG ≤ 17, MySQL 8.0</small></td></tr>
<tr><td>SQL Server managé</td><td>✓</td><td class="gap">✗</td></tr>
<tr><td>Stockage objet</td><td>✓</td><td>✓ <small>S3</small></td></tr>
<tr><td>Secret Manager</td><td>✓</td><td>✓</td></tr>
<tr><td>Monitoring managé</td><td>✓</td><td>✓ <small>Cockpit</small></td></tr>
<tr><td>VPN site-à-site BGP</td><td>✓</td><td>✓</td></tr>
</tbody>
</table>
<table class="map">
<thead><tr><th>Brique</th><th>GCP</th><th>Scaleway</th></tr></thead>
<tbody>
<tr><td>Registre avec proxy et purge</td><td>✓</td><td class="gap">✗</td></tr>
<tr><td>Load Balancer régional</td><td>✓</td><td class="gap">✗ <small>annoncé T4</small></td></tr>
<tr><td>Accès privé à S3 et à l'API Kubernetes</td><td>✓</td><td class="gap">✗ <small>S3 annoncé</small></td></tr>
<tr><td>IAM par ressource</td><td>✓</td><td>~ <small>secrets, buckets</small></td></tr>
<tr><td>Workload Identity</td><td>✓</td><td class="gap">✗</td></tr>
<tr><td>Connexion aux bases via l'IAM</td><td>✓</td><td class="gap">✗</td></tr>
</tbody>
</table>
</div>

<p class="fixline">Presque tout existe. Ce qui manque, on le retrouve dans la suite.</p>

<!--
**⏱ 1 min**

Repères : bonne nouvelle d'abord, presque tout existe · à gauche, l'équivalent est là · à droite, ce qui manque ou est partiel · ne pas détailler, chaque ligne revient plus tard
- SQL Server : on en avait sur GCP, Scaleway ne propose que PostgreSQL et MySQL.
- En réserve : sur Scaleway, impossible de déplacer des ressources d'un projet à l'autre, et ce n'est pas sur la roadmap (revient dans la partie identité).
-->

---

<p class="eyebrow">La méthode</p>
<h1>On n'a pas refondu. On a translaté.</h1>

<table class="map">
<thead><tr><th>Sur GCP</th><th>Sur Scaleway</th><th>Statut</th></tr></thead>
<tbody>
<tr><td>VPC + pare-feu</td><td>VPC, Private Networks, ACL</td><td class="st"><span class="tag t-gene">partiel</span></td></tr>
<tr><td>Cloud Storage</td><td>Object Storage</td><td class="st"><span class="tag t-gene">partiel</span></td></tr>
<tr><td>GKE</td><td>Kapsule</td><td class="st"><span class="tag t-gene">partiel</span></td></tr>
<tr><td>Cloud SQL</td><td>RDB</td><td class="st"><span class="tag t-gene">partiel</span></td></tr>
<tr><td>Artifact Registry</td><td class="gap">Container Registry, écarté → Harbor</td><td class="st"><span class="tag t-mal">manque</span></td></tr>
<tr><td>Cloud Monitoring</td><td>Cockpit, fédéré chez nous</td><td class="st"><span class="tag t-ok">mieux</span></td></tr>
<tr><td>Terraform provider</td><td>Terraform provider</td><td class="st"><span class="tag t-gene">partiel</span></td></tr>
<tr><td>IAM fin, par ressource</td><td>IAM au niveau du projet</td><td class="st"><span class="tag t-rock">bloquant</span></td></tr>
<tr><td>Workload Identity</td><td class="gap">rien : des clés API</td><td class="st"><span class="tag t-rock">bloquant</span></td></tr>
</tbody>
</table>

<!--
- Cette architecture existait déjà sur GCP. On ne l'a pas refondue : on l'a translatée, brique par brique. C'était un choix : limiter le risque de la migration.
- C'est précisément là que les problèmes apparaissent : chaque brique doit trouver son équivalent, et certaines n'en ont pas tout à fait.
- Ce tableau, c'est notre plan de route : on remonte les couches, des plus basses aux plus hautes, et on finit par l'identité. C'est là que sont les deux bloquants.
- Disclaimer périmètre : on n'a testé que ce dont on avait besoin. Pas de MongoDB, pas d'OpenSearch managés : non couverts.
-->

---

<p class="eyebrow">Comment lire la suite</p>
<h1>Une échelle, quatre réponses</h1>

<div class="grid grid-cols-2 gap-10 mt-4">
<div class="scale">
<div><span class="tag t-gene">mineur</span><p>Pénible, mais on vit avec.</p></div>
<div><span class="tag t-mal">majeur</span><p>Ça coûte cher si on ne le connaît pas : panne, perte, gros détour.</p></div>
<div><span class="tag t-rock">bloquant</span><p>Ça remet en cause l'architecture ou la migration. </p></div>
</div>
<div class="verbs">
<div style="--c:var(--accent)"><b>Garder</b><span>ce qui marchait sur GCP</span></div>
<div style="--c:var(--ochre)"><b>Contourner</b><span>dans notre propre couche</span></div>
<div style="--c:var(--brick)"><b>Valider</b><span>en amont, par la mesure</span></div>
<div style="--c:var(--muted)"><b>Accepter</b><span>et l'écrire</span></div>
</div>
</div>

<!--
**⏱ 30 s**

Bloquant = à traiter avant de signer. Valider = avant de signer, POC ou mesure.

Repères : deux étiquettes par slide · gravité : mineur, majeur, bloquant · réponse : garder, contourner, valider, accepter · peu de vrais contournements
-->

---
layout: section
---

<p class="eyebrow">Couche 1</p>
<h1>Réseau</h1>

<!--
**⏱ Couche 1 : ~4 min**
-->

---

<h1>Les ACL de VPC sont sans état</h1>
<div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">contourner</span></div>

<div class="diagram-wrap"><svg class="diagram" viewBox="0 0 640 180" role="img" aria-label="Avec un pare-feu à état, une règle suffit et le retour est suivi d&#x27;office. Avec les ACL de VPC Scaleway, sans état, il faut une deuxième règle pour le retour." style="max-height:15rem"><defs><marker id="fw-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="fw-ok" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker><marker id="fw-bad" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--brick)"></path></marker></defs><text class="s-title" x="0" y="48">Avec état</text><text class="s-txt" x="0" y="64">GCP, AWS</text><rect class="s-box" x="170" y="30" width="110" height="44" rx="5"></rect><text class="s-title" x="225" y="57" text-anchor="middle">Réseau A</text><rect class="s-box" x="500" y="30" width="110" height="44" rx="5"></rect><text class="s-title" x="555" y="57" text-anchor="middle">Réseau B</text><line class="s-line" x1="282" y1="44" x2="498" y2="44" marker-end="url(#fw-a)"></line><text class="s-lbl" x="390" y="38" text-anchor="middle">règle : A → B, port 5432</text><line class="s-ok" x1="498" y1="60" x2="282" y2="60" stroke-dasharray="5 4" marker-end="url(#fw-ok)"></line><text class="s-lbl-ok" x="390" y="78" text-anchor="middle">retour suivi d'office</text><text class="s-title" x="0" y="138">ACL de VPC</text><text class="s-txt" x="0" y="154">Scaleway, sans état</text><rect class="s-box" x="170" y="120" width="110" height="44" rx="5"></rect><text class="s-title" x="225" y="147" text-anchor="middle">Réseau A</text><rect class="s-box" x="500" y="120" width="110" height="44" rx="5"></rect><text class="s-title" x="555" y="147" text-anchor="middle">Réseau B</text><line class="s-line" x1="282" y1="134" x2="498" y2="134" marker-end="url(#fw-a)"></line><text class="s-lbl" x="390" y="128" text-anchor="middle">règle 1 : A → B, port 5432</text><line class="s-bad" x1="498" y1="150" x2="282" y2="150" marker-end="url(#fw-bad)"></line><text class="s-lbl-bad" x="390" y="168" text-anchor="middle">règle 2 : B → A, ports éphémères</text></svg></div>

<p class="fixline">Notre choix : filtrer dans Kubernetes, avec des <strong>Cilium Network Policies</strong>.</p>

<!--
- Une règle qui autorise un réseau à joindre un service d'un autre ne suffit pas : la réponse est bloquée tant qu'une seconde règle, dans l'autre sens, ne l'autorise pas.
- Les ACL de VPC ne suivent pas les connexions : pas de conntrack. Les pare-feux GCP ou les security groups AWS autorisent le retour d'office.
- En 2026, écrire l'aller ET le retour, c'est pénible, et ça double les règles à relire.
- **Notre contournement :** tout tourne dans Kubernetes, donc on filtre avec Cilium : avec état, au niveau des pods, beaucoup plus fin. On ne dépend plus des ACL.
- Pas rédhibitoire, mais c'est le seul vrai contournement de la couche réseau.
-->

---

<p class="eyebrow">Réseau · en rafale</p>
<h1>Le reste de la couche réseau</h1>

<div class="mini">
<div><div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">accepter</span></div><b>LB et Public Gateways zonaux</b><p>Une zone porte l'entrée et la sortie du cluster.</p><span class="fix">Risque écrit et accepté. LB régional annoncé pour T4 2026.</span></div>
<div><div class="tags"><span class="tag t-rock">bloquant</span><span class="tag t-verb">valider</span></div><b>fr-par-3 incomplète</b><p>42 types d'instance, contre 125 et 134. Pas de Public Gateway.</p><span class="fix">Vérifier zone par zone ; composants sur 2 zones assumés.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">contourner</span></div><b>Peering : des routes à redéclarer</b><p>Pas de propagation constatée chez nous (cause non élucidée).</p><span class="fix">Routes déclarées dans le code, table vérifiée de chaque côté.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">accepter</span></div><b>Pas de chemin privé : API Kapsule, S3</b><p>API server : DNS et certificat publics uniquement. S3 : pas de VPC endpoint.</p><span class="fix">Liste d'IP + IP de sortie fixe ; Public Gateway dimensionnée.</span></div>
</div>

<!--
**Règle : 20 s par carte. Le titre, la solution, et on passe. Un seul « c'est pénible » pour toute la slide.**

**LB et Public Gateways zonaux** (le plus pénible des quatre)
- Un LB vit dans une zone. Une Public Gateway aussi, et on ne peut pas répartir la sortie d'un Private Network entre plusieurs gateways. Un cluster sur 3 zones a donc une entrée ET une sortie mono-zone.
- On ne promet pas la tolérance à la perte d'une zone sur ces deux chemins. LB régional annoncé pour ce trimestre.

**fr-par-3**
- 42 types d'instance contre 125 (fr-par-1) et 134 (fr-par-2), relevé le 1er octobre 2026. Pas de Public Gateway : l'API répond « unknown service ».
- Un « 3 AZ propre » comme sur GCP n'est pas acquis : `scw instance server-type list zone=fr-par-3` avant de concevoir.

**Peering**
- Selon Scaleway, les routes sont propagées. Nous ne l'avons pas constaté. À vérifier chez vous, pas un défaut établi.

**Pas de chemin privé**
- L'API server Kapsule n'est joignable que par son endpoint public : le DNS et le certificat ne supportent pas le privé. Notre ArgoCD central passe donc par Internet, restreint par liste d'IP.
- Object Storage : tout le trafic S3 sort par la Public Gateway, sauvegardes comprises. L'équivalent des VPC endpoints est annoncé dans l'année : on pourra alors passer S3 en privé.
-->

---
layout: section
---

<p class="eyebrow">Couche 2</p>
<h1>Kapsule</h1>

<!--
**⏱ Couche 3 : ~5 min.** Globalement, Kapsule nous a posé peu de problèmes, sauf un.
-->

---

<h1>p99 &lt; 1 s à 250 req/s : un no-go</h1>
<div class="tags"><span class="tag t-rock">bloquant</span><span class="tag t-verb">valider</span></div>

<div class="stats" style="grid-template-columns:1fr 1fr"><div><b>p99 &lt; 1 s</b><span>sur l'API Kubernetes</span></div><div><b>250 req/s</b><span>en pic : ArgoCD et nos operators</span></div></div>

<div class="cards"><div><b>Plan mutualisé</b><p>Pas de SLA.</p></div><div><b>Plans dédiés</b><p>SLA de 99,5 %.</p></div><div style="border-color:var(--brick);background:var(--brick-bg)"><b>Notre charge</b><p>No-go pour la migration, jusqu'à une solution trouvée avec Scaleway.</p></div></div>

<p class="fixline">Mesurez votre charge sur l'API et validez-la avec Scaleway.</p>

<!--
- Notre SLO sur l'API server : p99 sous la seconde, avec des pics à 250 requêtes par seconde.
- Pourquoi si haut ? ArgoCD et pas mal d'operators réconcilient en continu contre l'API.
- Le plan de contrôle est géré par Scaleway : on ne règle ni l'API server ni etcd. Le seul levier, c'est l'offre et le dialogue avec Scaleway.
- Tant que ce n'était pas tenu, c'était no-go pour la migration. On a trouvé une solution avec les équipes Scaleway.
- **La leçon :** posez latence visée et pic de requêtes comme critère go/no-go dès le départ, faites-les valider avant de signer, mesurez `apiserver_request_duration_seconds` dès le jour 1. La plus grosse offre du catalogue ne suffit pas forcément.

**Si la question vient sur la solution :** « c'est spécifique à notre contexte, je vous invite à en parler directement avec Scaleway ». Ne rien détailler, ni sur scène ni en aparté.
-->

---

<p class="eyebrow">Kapsule · en rafale</p>
<h1>Le reste de Kapsule</h1>

<div class="mini">
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">accepter</span></div><b>Les mineures, c'est vous</b><p>Patchs gérés, montées de mineure à déclencher.</p><span class="fix">Chantier récurrent, hors prod d'abord.</span></div>
<div><div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">contourner</span></div><b>Changer de type recrée le pool</b><p>Pas de rolling update : supprimé, puis recréé.</p><span class="fix">Nouveau pool à côté, drain, puis suppression.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">valider</span></div><b>Petits nœuds, grosse taxe</b><p>Chez nous, ~1 Go de DaemonSets par nœud, plus la réserve Kapsule.</p><span class="fix">Partir sur du 16 Go plutôt que du 8.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">contourner</span></div><b>Pas de snapshots CSI</b><p>Aucune VolumeSnapshotClass.</p><span class="fix">Velero vers S3, avec alerte.</span></div>
</div>

<!--
**Règle : 20 s par carte. Le titre, la solution, et on passe. Un seul « c'est pénible » pour toute la slide.**

**Mineures** : sur GKE, les canaux de release s'en chargent. Ici, c'est à nous, comme sur EKS. Pas un gros problème. (L'anecdote de la descente de version est gardée pour la partie provider.)

**Type d'instance** : labels et taints identiques sur le nouveau pool pour que les nodeSelector suivent. Attention aux PDB qui bloquent le drain.

**Petits nœuds** : Cilium seul prend environ 500 Mo par nœud. Avec ce qu'on ajoute (Tetragon, Fluent Bit…), on arrive à environ 1 Go de DaemonSets par nœud, en plus de la réserve Kapsule. Sur des nœuds de 8 Go, c'est peu rentable : partir sur du 16, pour mieux faire du bin packing.

**Snapshots CSI** : Velero pour sauvegarder les volumes vers S3, alerte quand l'emplacement de sauvegarde devient indisponible.
-->

---
layout: section
---

<p class="eyebrow">Couche 3</p>
<h1>Bases managées</h1>

<!--
**⏱ Couche 4 : ~6 min.** RDB fait correctement le travail. Les surprises sont sur la réplication et les logs.
-->

---

<h1>MySQL : pas de réplication native</h1>
<div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">accepter</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:19rem" viewBox="0 0 760 270" role="img" aria-label="Entre Cloud SQL MySQL et RDB MySQL, aucune réplication native dans un sens comme dans l&#x27;autre ; en natif, il reste un dump avec mydumper, une fenêtre de coupure, puis une restauration dans RDB."><defs><marker id="my-ok" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker></defs><text class="s-lbl-bad" x="380" y="22" text-anchor="middle" style="font-size:13px;font-weight:700">réplication native : ni dans un sens, ni dans l'autre</text><rect class="s-box" x="20" y="35" width="210" height="74" rx="6"></rect><text class="s-title" x="125" y="66" text-anchor="middle">Cloud SQL</text><text class="s-txt" x="125" y="88" text-anchor="middle">MySQL (source)</text><rect class="s-box" x="530" y="35" width="210" height="74" rx="6"></rect><text class="s-title" x="635" y="66" text-anchor="middle">RDB « MySQL-8 »</text><text class="s-txt" x="635" y="88" text-anchor="middle">en réalité 8.0.21 (2020)</text><line class="s-no" x1="232" y1="60" x2="528" y2="60"></line><line class="s-no" x1="232" y1="84" x2="528" y2="84"></line><line x1="364" y1="56" x2="396" y2="88" style="stroke:var(--brick);stroke-width:3"></line><line x1="396" y1="56" x2="364" y2="88" style="stroke:var(--brick);stroke-width:3"></line><text class="s-lbl-ok" x="380" y="172" text-anchor="middle" style="font-size:12px">en natif : dump, coupure, restore</text><rect class="s-box" x="20" y="190" width="210" height="50" rx="6"></rect><text class="s-title" x="125" y="220" text-anchor="middle">dump · mydumper</text><rect class="s-badbox" x="275" y="190" width="210" height="50" rx="6"></rect><text class="s-title" x="380" y="220" text-anchor="middle">fenêtre de coupure</text><rect class="s-box" x="530" y="190" width="210" height="50" rx="6"></rect><text class="s-title" x="635" y="220" text-anchor="middle">restore dans RDB</text><line class="s-ok" x1="125" y1="111" x2="125" y2="186" marker-end="url(#my-ok)"></line><line class="s-ok" x1="232" y1="215" x2="271" y2="215" marker-end="url(#my-ok)"></line><line class="s-ok" x1="487" y1="215" x2="526" y2="215" marker-end="url(#my-ok)"></line><line class="s-ok" x1="635" y1="188" x2="635" y2="113" marker-end="url(#my-ok)"></line></svg></div>

<!--
- Impossible de faire de RDB un réplica d'une source externe, ou la source d'un réplica externe.
- Aucun compte, admin compris, n'a SUPER ni REPLICATION_SLAVE_ADMIN ; REPLICATION CLIENT n'est pas attribuable. Aucun réglage binlog ou GTID exposé.
- Un seul moteur, « MySQL-8 », en réalité un 8.0.21 de 2020 (lu dans le handshake). Fin de vie annoncée en avril 2028.
- **Ce qu'on fait :** dump/restore avec mydumper (`--enable-binlog` obligatoire), qui peut passer par le VPN, mais c'est une action manuelle, dans une fenêtre de coupure. Pas de retour arrière sans perte.
- Alternative non native : du CDC (Debezium).
- Une source plus récente que 8.0.21, c'est un downgrade.
-->

---

<h1>Réplication PostgreSQL : par Internet, depuis 14 plages</h1>
<div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">accepter</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:19rem" viewBox="0 0 760 270" role="img" aria-label="La réplication de RDB vers la base source ne peut pas passer par l&#x27;IP privée. Elle sort par une IP publique de l&#x27;ASN Scaleway, qui compte 14 plages, sans savoir laquelle : le pare-feu de la source doit autoriser les 14."><defs><marker id="rr-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-hub" x="20" y="30" width="200" height="64" rx="6"></rect><text class="s-title" x="120" y="58" text-anchor="middle">RDB PostgreSQL</text><text class="s-txt" x="120" y="78" text-anchor="middle">abonné</text><rect class="s-box" x="540" y="30" width="200" height="64" rx="6"></rect><text class="s-title" x="640" y="58" text-anchor="middle">Base source</text><text class="s-txt" x="640" y="78" text-anchor="middle">Cloud SQL</text><line class="s-no" x1="222" y1="62" x2="538" y2="62"></line><line x1="366" y1="48" x2="394" y2="76" style="stroke:var(--brick);stroke-width:3"></line><line x1="394" y1="48" x2="366" y2="76" style="stroke:var(--brick);stroke-width:3"></line><text class="s-lbl-bad" x="380" y="40" text-anchor="middle">par l'IP privée ou le VPN : impossible</text><polyline class="s-line" points="120,96 120,200 276,200" marker-end="url(#rr-a)"></polyline><text class="s-lbl" x="128" y="150">sort par Internet</text><rect class="s-badbox" x="280" y="140" width="200" height="110" rx="6"></rect><text class="s-title" x="380" y="162" text-anchor="middle">ASN Scaleway · 14 plages</text><rect x="295" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="320" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="345" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="370" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="395" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="420" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="445" y="176" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="295" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="320" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="345" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="370" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="395" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="420" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><rect x="445" y="198" width="20" height="16" style="fill:var(--surface);stroke:var(--brick)"></rect><text class="s-lbl-bad" x="380" y="238" text-anchor="middle">laquelle ? impossible à savoir</text><rect class="s-badbox" x="540" y="150" width="200" height="90" rx="6"></rect><text class="s-title" x="640" y="180" text-anchor="middle">Pare-feu de la source</text><text class="s-lbl-bad" x="640" y="204" text-anchor="middle">autoriser les 14 plages</text><line class="s-line" x1="482" y1="195" x2="538" y2="195" marker-end="url(#rr-a)"></line><line class="s-line" x1="640" y1="148" x2="640" y2="98" marker-end="url(#rr-a)"></line></svg></div>

<p class="fixline">Autoriser les 14 plages côté source. Si toute exposition est interdite : un connecteur CDC dans un pod.</p>

<!--
- La bonne nouvelle d'abord : PostgreSQL RDB sait s'abonner à Cloud SQL en réplication logique. C'est notre chemin de migration sans coupure longue.
- Le piège : impossible de passer par l'IP privée. Le nœud RDB initie la connexion depuis son interface de gestion publique, même avec un endpoint privé et un VPN fonctionnel.
- Des heures passées à déboguer VPN et peering pour rien : la souscription ne passe tout simplement pas par là.
- L'IP appartient à l'ASN Scaleway, 14 plages, sans savoir laquelle. Donc côté source : autoriser les 14. Pas vraiment du moindre privilège.
- Pas besoin de créer un endpoint public sur l'instance RDB : l'interface de gestion existe toujours.
-->

---

<h1>Les bases : pas d'identité humaine</h1>
<div class="tags"><span class="tag t-rock">bloquant</span><span class="tag t-verb">accepter</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:17rem" viewBox="0 0 760 250" role="img" aria-label="Sur GCP, chaque utilisateur se connecte à Cloud SQL avec son identité IAM et chaque requête est tracée à son nom. Sur Scaleway, tous les utilisateurs passent par un même compte générique en lecture seule : on ne sait plus qui a lancé quelle requête."><defs><marker id="db-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="db-ok" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker></defs><text class="s-title" x="0" y="58">GCP</text><rect class="s-box" x="90" y="34" width="150" height="40" rx="5"></rect><text class="s-title" x="165" y="59" text-anchor="middle">alice@ (IAM)</text><rect class="s-box" x="560" y="34" width="180" height="40" rx="5"></rect><text class="s-title" x="650" y="59" text-anchor="middle">Cloud SQL</text><line class="s-ok" x1="242" y1="54" x2="558" y2="54" marker-end="url(#db-ok)"></line><text class="s-lbl-ok" x="400" y="46" text-anchor="middle">authentification IAM</text><text class="s-txt" x="400" y="72" text-anchor="middle">chaque requête tracée au nom d'alice</text><line class="s-dash" x1="0" y1="100" x2="760" y2="100"></line><text class="s-title" x="0" y="175">Scaleway</text><rect class="s-box" x="90" y="120" width="150" height="32" rx="5"></rect><text class="s-lbl" x="165" y="141" text-anchor="middle">alice</text><rect class="s-box" x="90" y="160" width="150" height="32" rx="5"></rect><text class="s-lbl" x="165" y="181" text-anchor="middle">bob</text><rect class="s-box" x="90" y="200" width="150" height="32" rx="5"></rect><text class="s-lbl" x="165" y="221" text-anchor="middle">charlie</text><rect class="s-badbox" x="320" y="150" width="170" height="50" rx="5"></rect><text class="s-title" x="405" y="172" text-anchor="middle">compte générique</text><text class="s-txt" x="405" y="190" text-anchor="middle">lecture seule</text><rect class="s-box" x="560" y="155" width="180" height="40" rx="5"></rect><text class="s-title" x="650" y="180" text-anchor="middle">RDB</text><line class="s-line" x1="242" y1="136" x2="318" y2="166" marker-end="url(#db-a)"></line><line class="s-line" x1="242" y1="176" x2="318" y2="176" marker-end="url(#db-a)"></line><line class="s-line" x1="242" y1="216" x2="318" y2="186" marker-end="url(#db-a)"></line><line class="s-line" x1="492" y1="175" x2="558" y2="175" marker-end="url(#db-a)"></line><text class="s-lbl-bad" x="650" y="222" text-anchor="middle">qui a lancé cette requête ?</text></svg></div>

<p class="fixline">Un compte générique en lecture seule, blindé. On perd la traçabilité. Et ce n'est pas sur la roadmap.</p>

<!--
**⏱ ~1 min 30. À dire une seule fois.**

- Sur GCP, on reliait un humain à son accès à la base : on savait qui se connectait et qui faisait quoi.
- Sur Scaleway, impossible. Notre solution, qui n'est pas bonne : un compte générique, en lecture seule. Avec des droits d'écriture sur un compte partagé, on ne saurait plus qui a fait quoi.
- On perd la traçabilité. Et de mémoire, ce n'est même pas sur la roadmap.
-->

---

<p class="eyebrow">Bases · en rafale</p>
<h1>Le reste des bases managées</h1>

<div class="mini">
<div style="grid-column:span 2"><div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">contourner</span></div><b>Réplication et logs : mal configuré, rien ne prévient</b><p>54 tables sur 159 bloquées 11 jours, sans une ligne de log. Et les logs remplissent le disque : même volume que les données, sans rétention par défaut.</p><span class="fix">Surveiller <code>pg_stat_subscription_stats</code> ; rétention et alerte de remplissage dès la création.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">contourner</span></div><b>Exporter un backup : pas natif</b><p>Backup ou snapshot selon le disque. Pour une copie hors de l'instance, Scaleway propose du serverless.</p><span class="fix">Nous : un CronJob qui déclenche le backup via l'API Scaleway.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">valider</span></div><b>Des moteurs en retard</b><p>PostgreSQL 18 pas avant 2028. MySQL encore en 8.0.</p><span class="fix">Vérifier la version cible avant de migrer.</span></div>
</div>

<!--
**Règle : 20 s par carte. Le titre, la solution, et on passe. Un seul « c'est pénible » pour toute la slide.**

**Réplication et logs** (celui qui fait mal, une seule carte : si c'est mal configuré, on a des surprises)
- 54 tables sur 159 bloquées en synchronisation depuis onze jours, 36 449 erreurs comptées, et rien dans les logs de l'instance.
- `log_min_messages = log` n'est pas modifiable, et ERROR est sous LOG dans l'ordre de sévérité du serveur. `pg_stat_subscription` garde les dernières valeurs connues : une souscription morte peut paraître vivante.
- Surveiller `pg_stat_subscription_stats` côté RDB, lire la cause côté publisher.

- Logs : pas de métrique à part pour leur taille. Un disque peut se remplir sans données.

**Exporter un backup** (~40 s, pas plus) : le planning de backup fait un backup sur disque local, un snapshot sur disque bloc. Pour une copie exportée, Scaleway a une réponse : du serverless qui appelle la CLI ou l'API. C'est faisable, c'est juste pas natif. Nous, sur Kubernetes : un CronJob qui appelle directement l'API Scaleway pour déclencher le backup. Pas de dump vers un bucket. La restauration passe aussi par l'API. Au passage : pas d'autoresize des disques, donc surveiller le remplissage.

**Versions** : MySQL 8.4 annoncée pour T4 2026. Une source plus récente que ce que propose RDB impose un downgrade.
-->

---
layout: section
---

<p class="eyebrow">Couche 4</p>
<h1>Registre & observabilité</h1>

<!--
**⏱ Couche 5 : ~3 min**
-->

---

<h1>Container Registry : écarté</h1>
<div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">contourner</span></div>

<div class="grid grid-cols-2 gap-10 mt-6">
<ul class="yesno"><li class="y">stocker des images</li><li class="n">purge, rétention</li><li class="n">proxy vers Docker Hub</li><li class="n">configuration</li></ul>
<div style="display:grid;align-content:center;gap:.6rem"><div style="font-family:Archivo,sans-serif;font-size:2.4rem;font-weight:800;font-stretch:80%;line-height:1.05">On a monté<br>notre Harbor.</div><p class="muted">Dans le hub : proxy des registres publics, et nos images buildées.</p></div>
</div>

<!--
- C'est la brique qui ne se translate pas. On l'a regardé, on l'a écarté direct.
- Il stocke des images Docker, et c'est tout. Pas de purge, pas de rétention, pas de proxy vers Docker Hub, quasiment aucune configuration.
- Google Artifact Registry part avec GCP.
- On a monté notre propre registre, Harbor, dans le hub : proxys vers les registres publics, et nos images buildées dedans.
-->

---

<h1>On consomme Cockpit, on n'en dépend pas</h1>
<div class="tags"><span class="tag t-ok">notre choix</span><span class="tag t-verb">garder</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:19rem" viewBox="0 0 760 280" role="img" aria-label="Sur GCP, Grafana interroge deux datasources : Prometheus et Cloud Monitoring. Sur Scaleway, Cockpit se fédère dans notre Prometheus : Grafana n&#x27;a qu&#x27;une datasource."><defs><marker id="ck-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="ck-ok" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker></defs><line class="s-dash" x1="380" y1="10" x2="380" y2="270"></line><text class="s-big" x="190" y="30" text-anchor="middle">GCP</text><rect class="s-box" x="20" y="60" width="150" height="44" rx="5"></rect><text class="s-title" x="95" y="87" text-anchor="middle">Prometheus</text><rect class="s-box" x="200" y="60" width="160" height="44" rx="5"></rect><text class="s-title" x="280" y="87" text-anchor="middle">Cloud Monitoring</text><rect class="s-box" x="110" y="190" width="160" height="44" rx="5"></rect><text class="s-title" x="190" y="217" text-anchor="middle">Grafana</text><line class="s-line" x1="95" y1="106" x2="160" y2="188" marker-end="url(#ck-a)"></line><line class="s-line" x1="280" y1="106" x2="220" y2="188" marker-end="url(#ck-a)"></line><text class="s-txt" x="110" y="152" text-anchor="end">datasource 1</text><text class="s-txt" x="262" y="152">datasource 2</text><text class="s-lbl-bad" x="190" y="258" text-anchor="middle">deux sources à croiser</text><text class="s-big" x="570" y="30" text-anchor="middle">Scaleway</text><rect class="s-box" x="400" y="60" width="140" height="44" rx="5"></rect><text class="s-title" x="470" y="87" text-anchor="middle">Cockpit</text><rect class="s-box" x="400" y="125" width="140" height="44" rx="5"></rect><text class="s-title" x="470" y="152" text-anchor="middle">nos métriques</text><rect class="s-hub" x="600" y="90" width="140" height="44" rx="5"></rect><text class="s-title" x="670" y="117" text-anchor="middle">Prometheus</text><rect class="s-box" x="590" y="190" width="160" height="44" rx="5"></rect><text class="s-title" x="670" y="217" text-anchor="middle">Grafana</text><line class="s-ok" x1="542" y1="82" x2="598" y2="104" marker-end="url(#ck-ok)"></line><text class="s-lbl-ok" x="570" y="70" text-anchor="middle">fédération</text><line class="s-line" x1="542" y1="147" x2="598" y2="122" marker-end="url(#ck-a)"></line><line class="s-ok" x1="670" y1="136" x2="670" y2="188" marker-end="url(#ck-ok)"></line><text class="s-lbl-ok" x="670" y="258" text-anchor="middle">une seule datasource</text></svg></div>

<p class="fixline">Notre stack vit dans le hub : <strong>VictoriaMetrics, VictoriaLogs, VictoriaTraces</strong>. Cockpit n'est qu'une source de plus.</p>

<!--
- Ce n'est pas du Scaleway pur, c'est un choix d'architecture qu'on assume : on ne se repose pas sur le monitoring du provider.
- On a déployé notre propre stack dans le hub, toute la famille Victoria : VictoriaMetrics, VictoriaLogs, VictoriaTraces. Juste le citer, ne pas détailler : c'est une porte ouverte pour les questions.
- On y fédère Cockpit : les métriques des produits managés (LB, Public Gateways, sans agent) arrivent dans la même datasource que nos métriques métier.
- Sur GCP, Cloud Monitoring restait une datasource à part dans Grafana. Ici, on croise les deux dans une même requête. C'est mieux.
- Et on reste indépendants du provider : si demain on bouge, l'observabilité ne bouge pas.
- Point mineur : des métriques à interpréter soi-même. Pour une Public Gateway, la doc dit seulement « inbound/outbound » ; on a mesuré : receive = depuis Internet. Les LB créés par Kapsule s'appellent `<id cluster>_<uid>` : jointure sur l'UID du Service avec kube-state-metrics.
-->

---
layout: section
---

<p class="eyebrow">Couche 5</p>
<h1>Provider Terraform & API</h1>

<!--
**⏱ Couche 6 : ~3 min**
-->

---

<p class="eyebrow">Provider · en rafale</p>
<h1>Le provider est une passoire</h1>

<div class="grid grid-cols-5 gap-6 mt-2">
<div class="col-span-3">
<div class="cards" style="grid-template-columns:1fr;margin-top:0"><div style="border-color:var(--brick);background:var(--brick-bg)"><div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">valider</span></div><b>Kapsule en 1.36, je demande 1.35</b><p>Kubernetes ne sait pas redescendre. L'API répond : « OK, je le fais. »<br>Elle n'a rien fait, heureusement. Mais elle aurait dû dire non.</p></div></div>
<p class="fixline">Aucun check côté provider : le plan ne garantit pas l'apply. C'est encore plus vrai sur Scaleway.</p>
</div>
<div class="col-span-2 mini" style="grid-template-columns:1fr">
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">contourner</span></div><b>Dans l'API, pas dans le provider</b><p>Des semaines de décalage, parfois.</p><span class="fix">Vérifier dans le provider, pas dans l'annonce.</span></div>
<div><div class="tags"><span class="tag t-gene">mineur</span><span class="tag t-verb">accepter</span></div><b>Une doc pauvre</b><p>Plus rapide de lire le swagger.</p><span class="fix">Swagger et SDK Go comme référence.</span></div>
</div>
</div>

<!--
**⏱ Une seule anecdote : la 1.35. Le reste en une phrase chacun.**

**Le message :** le provider ne fait aucun check, il appelle le SDK Go et laisse l'API trancher. Un plan vert ne garantit pas l'apply, et c'est encore plus vrai sur Scaleway.

**L'anecdote** (1 min max)
- J'avais un Kapsule en 1.36, et par erreur j'ai demandé une 1.35. Ceux qui font du Kubernetes savent que c'est impossible : l'API devrait refuser.
- L'API m'a dit oui. Elle n'a rien fait, rassurez-vous. Mais le fait qu'elle dise oui, c'est le problème : le provider ne fait aucune validation, il appelle le SDK Go et laisse l'API trancher. Le plan ne veut pas tout dire.

**En une phrase chacun**
- Décalage API / provider : une fonction peut exister dans l'API et pas dans le provider, parfois pendant des semaines. Exemple : la PSK du VPN site-à-site.
- Doc pauvre : il m'est arrivé d'aller plus vite dans le swagger que dans la doc.

*En réserve, pour les questions seulement :* une mineure (v2.83) qui a changé l'identité de trois ressources RDB, un seul cas et légitime ; l'ordre des listes qui provoque des diffs permanents (trier en amont) ; `max_unavailable` hors bornes, plan vert et apply rouge ; les logs RDB trouvés dans le SDK.
-->

---
layout: section
---

<p class="eyebrow">Couche 6</p>
<h1>Object Storage</h1>

<!--
**⏱ Couche 6 : ~4 min.** Le 403, puis les bucket policies. On termine sur les buckets : c'est la porte d'entrée vers l'identité.
-->

---

<h1>Un 403 S3 malgré une policy parfaite</h1>
<div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">contourner</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:19rem" viewBox="0 0 760 290" role="img" aria-label="La clé API a pour projet par défaut P1. La requête S3 n&#x27;a pas de champ projet : Scaleway cherche le bucket dans P1, n&#x27;y trouve rien et renvoie 403, alors que le bucket est dans P2."><defs><marker id="s3-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="s3-b" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--brick)"></path></marker></defs><rect class="s-box" x="20" y="100" width="190" height="80" rx="6"></rect><text class="s-title" x="115" y="132" text-anchor="middle">Clé API</text><text class="s-txt" x="115" y="156" text-anchor="middle">projet par défaut : P1</text><line class="s-line" x1="212" y1="140" x2="298" y2="140" marker-end="url(#s3-a)"></line><text class="s-lbl" x="255" y="130" text-anchor="middle" style="font-size:10px">requête S3</text><text class="s-txt" x="255" y="160" text-anchor="middle" style="font-size:10px">sans projet</text><rect class="s-hub" x="300" y="100" width="180" height="80" rx="6"></rect><text class="s-title" x="390" y="132" text-anchor="middle">Scaleway S3</text><text class="s-txt" x="390" y="156" text-anchor="middle">cherche dans P1</text><rect class="s-badbox" x="560" y="20" width="180" height="100" rx="6"></rect><text class="s-title" x="650" y="50" text-anchor="middle">Projet P1</text><text class="s-txt" x="650" y="72" text-anchor="middle">aucun bucket</text><text class="s-big" x="650" y="104" text-anchor="middle" style="fill:var(--brick)">403</text><rect class="s-box" x="560" y="170" width="180" height="100" rx="6"></rect><text class="s-title" x="650" y="200" text-anchor="middle">Projet P2</text><text class="s-txt" x="650" y="222" text-anchor="middle">le bucket est ici</text><text class="s-txt" x="650" y="244" text-anchor="middle">jamais consulté</text><line class="s-bad" x1="482" y1="125" x2="558" y2="80" marker-end="url(#s3-b)"></line><line class="s-dash" x1="482" y1="160" x2="558" y2="215"></line></svg></div>

<p class="fixline">Chaque clé S3 a pour projet par défaut celui de son bucket. Devant un 403 : <code>scw iam api-key get</code>.</p>

<!--
- 403 AccessDenied sur ListObjectsV2, alors que l'IAM et la bucket policy autorisent explicitement l'accès, même pour un admin d'organisation. Le même module Terraform marchait dans un projet, pas dans l'autre.
- Le protocole S3 n'a pas de champ « projet » : Scaleway cherche le bucket dans le projet par défaut de la clé API. Le project-id passé dans la requête est ignoré.
- Dans le premier projet, les deux coïncidaient : coup de chance.
- Devant un 403 : comparer `default_project_id` AVANT de toucher la policy.
- Au passage : pas de réplication de buckets. Copie planifiée (rclone) avec sa propre supervision.
- Le reste d'Object Storage fonctionne bien : c'est du S3 compatible, nos outils marchent sans adaptation.
-->

---

<h1>Bucket policies : qui a vraiment accès ?</h1>
<div class="tags"><span class="tag t-mal">majeur</span><span class="tag t-verb">contourner</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:16.5rem" viewBox="0 0 800 320" role="img" aria-label="Arbre de décision : si l&#x27;IAM n&#x27;autorise pas l&#x27;action, refusé. Sinon, si le bucket n&#x27;a pas de policy, autorisé. Sinon, autorisé seulement si la policy autorise explicitement ce principal et cette action ; sinon refusé."><defs><marker id="bp-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><text class="s-lbl-bad" x="400" y="30" text-anchor="middle" style="font-size:13px;font-weight:700">Dès qu'une policy existe, tout principal non listé est refusé. Vous compris.</text><text class="s-txt" x="400" y="52" text-anchor="middle">Principal : user_id, application_id ou * — pas de groupe IAM. Deny inutile.</text><rect class="s-box" x="20" y="110" width="180" height="70" rx="6"></rect><text class="s-title" x="110" y="140" text-anchor="middle">L'IAM autorise</text><text class="s-title" x="110" y="160" text-anchor="middle">l'action ?</text><rect class="s-box" x="290" y="110" width="180" height="70" rx="6"></rect><text class="s-title" x="380" y="140" text-anchor="middle">Le bucket a</text><text class="s-title" x="380" y="160" text-anchor="middle">une policy ?</text><rect class="s-box" x="560" y="110" width="220" height="70" rx="6"></rect><text class="s-title" x="670" y="140" text-anchor="middle">Elle autorise ce principal</text><text class="s-title" x="670" y="160" text-anchor="middle">et cette action ?</text><line class="s-line" x1="202" y1="145" x2="288" y2="145" marker-end="url(#bp-a)"></line><text class="s-lbl" x="245" y="137" text-anchor="middle">oui</text><line class="s-line" x1="472" y1="145" x2="558" y2="145" marker-end="url(#bp-a)"></line><text class="s-lbl" x="515" y="137" text-anchor="middle">oui</text><line class="s-line" x1="110" y1="182" x2="110" y2="246" marker-end="url(#bp-a)"></line><text class="s-lbl" x="120" y="218">non</text><line class="s-line" x1="380" y1="182" x2="380" y2="246" marker-end="url(#bp-a)"></line><text class="s-lbl" x="390" y="218">non</text><line class="s-line" x1="615" y1="182" x2="615" y2="246" marker-end="url(#bp-a)"></line><text class="s-lbl" x="625" y="218">oui</text><line class="s-line" x1="735" y1="182" x2="735" y2="246" marker-end="url(#bp-a)"></line><text class="s-lbl" x="745" y="218">non</text><rect class="s-badbox" x="20" y="250" width="180" height="44" rx="6"></rect><text class="s-title" x="110" y="277" text-anchor="middle">Refusé</text><rect class="s-okbox" x="290" y="250" width="180" height="44" rx="6"></rect><text class="s-title" x="380" y="277" text-anchor="middle">Autorisé</text><rect class="s-okbox" x="560" y="250" width="105" height="44" rx="6"></rect><text class="s-title" x="612" y="277" text-anchor="middle">Autorisé</text><rect class="s-badbox" x="680" y="250" width="100" height="44" rx="6"></rect><text class="s-title" x="730" y="277" text-anchor="middle">Refusé</text><text class="s-txt" x="400" y="316" text-anchor="middle" style="font-size:10px">D'après la documentation Scaleway, « Bucket policies overview »</text></svg></div>

<p class="fixline">Notre réponse : des policies générées par Terramate, jamais à la main. La CI toujours dedans, les admins au moins en lecture.</p>

<!--
**⏱ ~2 min. Un seul « c'est pénible », pas dix.**

- Deux niveaux de contrôle : l'IAM de l'application doit autoriser l'action, ET la bucket policy aussi.
- **Une seule policy par bucket.** Une policy peut couvrir plusieurs buckets, pas l'inverse. Elle doit donc tout lister d'un coup : humains, CI, applications.
- **Pas de groupes** : seulement des user_id et des application_id. Pour un groupe, il faut lister ses membres, et regénérer à chaque arrivée.
- Je me suis enfermé dehors plusieurs fois.
- Notre réponse : tout est généré par le code avec Terramate. La CI est toujours autorisée, les admins au moins en lecture. Une policy complète à chaque fois.
- *En réserve :* `s3:DeleteBucket` existe dans l'IAM mais pas dans le langage de bucket policy (MalformedPolicy). Porte de sortie si on s'enferme : le propriétaire de l'organisation.
-->

---
layout: section
---

<p class="eyebrow">Le final</p>
<h1>Identité</h1>

<!--
**⏱ Identité : ~10 min.** C'est le cœur du talk.

Repères transition : jusqu'ici du mineur et du majeur · maintenant le bloquant · l'identité

**Le fil, dans l'ordre des slides :**
1. Qui peut toucher à quoi : seulement deux briques fines (secrets, buckets).
2. Les workloads : pas de Workload Identity.
3. Notre réponse : la rotation.
-->

---

<h1>Moindre privilège : qui peut toucher à quoi ?</h1>
<div class="tags"><span class="tag t-rock">bloquant</span><span class="tag t-verb">accepter</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:20rem" viewBox="0 0 760 334" role="img" aria-label="Dans un projet Scaleway, les secrets se restreignent par condition CEL, les buckets par bucket policy, Kapsule par RBACManager et des groupes ; RDB se connecte hors IAM (login, mot de passe, IP) ; le reste n'a que admin, edit ou view sur tout le projet."><rect class="s-zone" x="10" y="10" width="740" height="314" rx="6"></rect><text class="s-title" x="30" y="34">Projet Scaleway</text><rect class="s-hub" x="30" y="56" width="140" height="36" rx="5"></rect><text class="s-title" x="100" y="79" text-anchor="middle">Équipe A</text><rect class="s-hub" x="30" y="102" width="140" height="36" rx="5"></rect><text class="s-title" x="100" y="125" text-anchor="middle">Équipe B</text><rect class="s-hub" x="30" y="148" width="140" height="36" rx="5"></rect><text class="s-title" x="100" y="171" text-anchor="middle">Équipe C</text><text class="s-txt" x="100" y="206" text-anchor="middle">humains et</text><text class="s-txt" x="100" y="222" text-anchor="middle">applications IAM</text><rect class="s-okbox" x="220" y="48" width="520" height="48" rx="5"></rect><text class="s-title" x="240" y="70">Secrets</text><text class="s-txt" x="240" y="87">conditions CEL sur le chemin (depuis juillet)</text><text class="s-big" x="715" y="80" text-anchor="end" style="fill:var(--accent)">✓</text><rect class="s-okbox" x="220" y="102" width="520" height="48" rx="5"></rect><text class="s-title" x="240" y="124">Buckets</text><text class="s-txt" x="240" y="141">bucket policies (vues juste avant)</text><text class="s-big" x="715" y="134" text-anchor="end" style="fill:var(--accent)">✓</text><rect class="s-warnbox" x="220" y="156" width="520" height="48" rx="5"></rect><text class="s-title" x="240" y="178">Kapsule</text><text class="s-txt" x="240" y="195">admin, edit, view… finesse ajoutée par RBACManager et des groupes</text><text class="s-big" x="715" y="188" text-anchor="end" style="fill:var(--ochre)">~</text><rect class="s-box" x="220" y="210" width="520" height="48" rx="5"></rect><text class="s-title" x="240" y="232">RDB</text><text class="s-txt" x="240" y="249">hors IAM : on se connecte avec login, mot de passe et IP de la base</text><text class="s-big" x="715" y="242" text-anchor="end" style="fill:var(--muted)">—</text><rect class="s-badbox" x="220" y="264" width="520" height="48" rx="5"></rect><text class="s-title" x="240" y="286">Le reste</text><text class="s-txt" x="240" y="303">admin, edit, view : une permission vaut pour tout le projet</text><text class="s-big" x="715" y="296" text-anchor="end" style="fill:var(--brick)">✗</text></svg></div>

<p class="fixline">Notre compensation : les humains en lecture seule, seule la CI écrit, et Cilium entre les équipes.</p>

<!--
- L'idée : restreindre chaque équipe, humains comme applications IAM (l'équivalent des service accounts GCP), au strict minimum.
- **Deux briques seulement le permettent finement.** Les secrets, avec la syntaxe CEL depuis juillet. Les buckets, avec les bucket policies (vu juste avant).
- Kapsule : par défaut admin, edit, view, comme sur GCP. On ajoute la finesse nous-mêmes avec RBACManager et des groupes d'utilisateurs Scaleway. Et on passe surtout par ArgoCD : kubectl, c'est pour le port-forward.
- RDB : pas de permission IAM pour se connecter, contrairement à GCP. Il suffit d'un login, d'un mot de passe et de l'IP de la base. L'IAM sert à créer ou lister les bases (vu dans la partie bases).
- Le reste : admin, edit, view sur tout le projet.
- Comment on compense : les humains sont en lecture seule sur Scaleway ; seule la CI écrit, et seule l'infra merge sur main ; le destructif passe par un compte admin dédié ; Cilium isole les équipes côté réseau.
- **Le message :** le moindre privilège est indispensable en 2026. Sur Scaleway, il se conçoit au départ. Si on ne prend pas le temps, on ouvre des trous facilement.
-->

---

<h1>Pas de Workload Identity : des clés partout</h1>
<div class="tags"><span class="tag t-rock">bloquant</span><span class="tag t-verb">contourner</span><span class="tag t-verb">accepter</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:20rem" viewBox="0 0 760 300" role="img" aria-label="Sur GKE, un pod parle à l&#x27;API GCP par son identité, sans clé. Sur Kapsule, chaque pod a besoin d&#x27;une clé API stockée dans un Secret, y compris External Secrets, qui lit sa propre clé dans un Secret."><defs><marker id="wi-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker><marker id="wi-ok" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" style="fill:var(--accent)"></path></marker></defs><text class="s-title" x="0" y="62">GKE</text><rect class="s-box" x="90" y="35" width="140" height="44" rx="5"></rect><text class="s-title" x="160" y="62" text-anchor="middle">Pod</text><rect class="s-box" x="560" y="35" width="180" height="44" rx="5"></rect><text class="s-title" x="650" y="62" text-anchor="middle">API GCP</text><line class="s-ok" x1="232" y1="57" x2="558" y2="57" marker-end="url(#wi-ok)"></line><text class="s-lbl-ok" x="395" y="48" text-anchor="middle">identité du ServiceAccount</text><text class="s-txt" x="395" y="74" text-anchor="middle">aucune clé stockée</text><line class="s-dash" x1="0" y1="110" x2="760" y2="110"></line><text class="s-title" x="0" y="177">Kapsule</text><rect class="s-box" x="90" y="150" width="140" height="44" rx="5"></rect><text class="s-title" x="160" y="177" text-anchor="middle">Pod</text><rect class="s-badbox" x="325" y="145" width="140" height="54" rx="5"></rect><text class="s-title" x="395" y="168" text-anchor="middle">clé API</text><text class="s-txt" x="395" y="186" text-anchor="middle">dans un Secret</text><rect class="s-box" x="560" y="150" width="180" height="44" rx="5"></rect><text class="s-title" x="650" y="177" text-anchor="middle">API Scaleway</text><line class="s-line" x1="232" y1="172" x2="323" y2="172" marker-end="url(#wi-a)"></line><line class="s-line" x1="467" y1="172" x2="558" y2="172" marker-end="url(#wi-a)"></line><rect class="s-box" x="90" y="240" width="140" height="44" rx="5"></rect><text class="s-title" x="160" y="267" text-anchor="middle">External Secrets</text><rect class="s-badbox" x="325" y="235" width="140" height="54" rx="5"></rect><text class="s-title" x="395" y="258" text-anchor="middle">sa propre clé</text><text class="s-txt" x="395" y="276" text-anchor="middle">dans un Secret</text><rect class="s-box" x="560" y="240" width="180" height="44" rx="5"></rect><text class="s-title" x="650" y="267" text-anchor="middle">Secret Manager</text><line class="s-line" x1="232" y1="262" x2="323" y2="262" marker-end="url(#wi-a)"></line><line class="s-line" x1="467" y1="262" x2="558" y2="262" marker-end="url(#wi-a)"></line><text class="s-lbl-bad" x="395" y="224" text-anchor="middle">qui fait tourner cette clé ?</text></svg></div>

<!--
- On le savait avant de migrer, ce n'était pas une surprise. Mais c'est le deuxième bloquant.
- Rappel : sur GKE, on associe un ServiceAccount Kubernetes à un service account GCP. Le pod récupère ses permissions, sans clé. Tous les grands clouds le permettent.
- Chez Scaleway, ça n'existe pas, et ce n'est pas sur la roadmap.
- Donc des clés API partout. Soit sans expiration, et c'est une mauvaise idée. Soit avec une date limite posée au niveau de l'organisation, et il faut les faire tourner.
- Y compris le lecteur de secrets : External Secrets lit sa propre clé dans un Secret. La poule et l'œuf.
-->

---

<h1>Notre rotation</h1>
<div class="tags"><span class="tag t-rock">bloquant</span><span class="tag t-verb">contourner</span><span class="tag t-verb">accepter</span></div>

<div class="diagram-wrap"><svg class="diagram" style="max-height:16rem" viewBox="0 0 760 300" role="img" aria-label="Chaque jour ouvré à 6 heures, une pipeline GitLab CI lance Terramate sur les stacks taggées rotating ; terraform apply, via time_rotating, crée la nouvelle clé et révoque l'ancienne ; un script pousse directement la clé du lecteur de secrets puis rafraîchit External Secrets et PushSecrets. Une coupure de 2 à 5 minutes est acceptée entre 6 et 7 heures. Une clé vit 40 jours et tourne à 30 : 10 jours de marge."><defs><marker id="ro-a" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="currentColor"></path></marker></defs><rect class="s-hub" x="5" y="20" width="170" height="74" rx="6"></rect><text class="s-title" x="90" y="44" text-anchor="middle">06:00 · GitLab CI</text><text class="s-txt" x="90" y="63" text-anchor="middle">pipeline planifiée,</text><text class="s-txt" x="90" y="79" text-anchor="middle">jours ouvrés</text><rect class="s-box" x="195" y="20" width="170" height="74" rx="6"></rect><text class="s-title" x="280" y="44" text-anchor="middle">Terramate</text><text class="s-txt" x="280" y="63" text-anchor="middle">seulement les stacks</text><text class="s-txt" x="280" y="79" text-anchor="middle">taggées rotating</text><rect class="s-box" x="385" y="20" width="170" height="74" rx="6"></rect><text class="s-title" x="470" y="44" text-anchor="middle">terraform apply</text><text class="s-txt" x="470" y="63" text-anchor="middle">time_rotating : nouvelle</text><text class="s-txt" x="470" y="79" text-anchor="middle">clé, ancienne révoquée</text><rect class="s-box" x="575" y="20" width="180" height="74" rx="6"></rect><text class="s-title" x="665" y="44" text-anchor="middle">script</text><text class="s-txt" x="665" y="63" text-anchor="middle">push direct de la clé,</text><text class="s-txt" x="665" y="79" text-anchor="middle">refresh ESO et PushSecrets</text><line class="s-line" x1="177" y1="57" x2="193" y2="57" marker-end="url(#ro-a)"></line><line class="s-line" x1="367" y1="57" x2="383" y2="57" marker-end="url(#ro-a)"></line><line class="s-line" x1="557" y1="57" x2="573" y2="57" marker-end="url(#ro-a)"></line><line class="s-bad" x1="390" y1="112" x2="750" y2="112"></line><line class="s-bad" x1="390" y1="106" x2="390" y2="118"></line><line class="s-bad" x1="750" y1="106" x2="750" y2="118"></line><text class="s-lbl-bad" x="570" y="132" text-anchor="middle" style="font-weight:700">coupure de 2 à 5 min, assumée : 6 h – 7 h, avant l'arrivée des Ops</text><rect class="s-okbox" x="60" y="190" width="460" height="22" rx="3"></rect><rect class="s-warnbox" x="520" y="190" width="170" height="22" rx="3"></rect><text class="s-lbl" x="290" y="205" text-anchor="middle">clé valide</text><text class="s-lbl-warn" x="605" y="205" text-anchor="middle" style="font-weight:700">marge : 10 jours</text><line class="s-line" x1="40" y1="240" x2="720" y2="240" marker-end="url(#ro-a)"></line><line class="s-line" x1="60" y1="233" x2="60" y2="247"></line><line class="s-line" x1="520" y1="233" x2="520" y2="247"></line><line class="s-line" x1="690" y1="233" x2="690" y2="247"></line><text class="s-title" x="60" y="266" text-anchor="middle">J0</text><text class="s-txt" x="60" y="283" text-anchor="middle">clé créée</text><text class="s-title" x="520" y="266" text-anchor="middle">J30</text><text class="s-txt" x="520" y="283" text-anchor="middle">rotation</text><text class="s-title" x="690" y="266" text-anchor="middle">J40</text><text class="s-txt" x="690" y="283" text-anchor="middle">expiration</text><line class="s-dash" x1="520" y1="186" x2="520" y2="140"></line></svg></div>

<p class="fixline">~100 clés API Scaleway, plus tokens et mots de passe · 40 jours de vie, rotation à 30 · 2 à 5 min de coupure, assumée.</p>

<!--
- Toutes nos ressources cloud sont dans Terraform : c'est donc Terraform qui fait la rotation, avec `time_rotating`.
- La pipeline tourne les jours ouvrés à 6 h. Pas le week-end : on ne lance pas une rotation quand personne n'est là pour réparer. Terramate ne touche que les stacks taggées `rotating`.
- Une clé vit 40 jours et tourne à 30 : de la marge pour le week-end et les imprévus.
- Juste après l'apply, un script pousse directement la clé du lecteur de secrets, puis force le refresh des ExternalSecrets et des PushSecrets.
- On accepte une coupure de 2 à 5 minutes. On a choisi quand : tôt le matin, avant que les Ops arrivent. C'est un choix.
- Le volume : une centaine de clés côté Scaleway. Et si on ajoute les tokens Gandi et GitLab, les mots de passe de bases et de RabbitMQ, beaucoup plus.

**Si la question vient sur la double clé :** faisable (deux clés décalées). On a choisi de ne pas compliquer un problème que le provider devrait résoudre.
-->

---
layout: section
---

<p class="eyebrow">Le bilan</p>
<h1>Ce qu'il faut retenir</h1>

<!--
**⏱ Bilan : ~4 min.** Être tranchant : ne pas relire les slides.
-->

---

<p class="eyebrow">Avant de migrer</p>
<h1>Trois chantiers à préparer</h1>

<div class="cards">
<div style="border-color:var(--brick)"><b>Identité</b><p>Concevez votre découpage de projets et vos permissions avant tout le reste. C'est lui qui fait votre sécurité.</p></div>
<div style="border-color:var(--brick)"><b>Rotation</b><p>Sans Workload Identity, chaque clé doit tourner. Outillez la rotation dès le premier jour.</p></div>
<div style="border-color:var(--ochre)"><b>Flux</b><p>Pas de 100 % privé, LB et gateways zonaux, réplication par Internet. Dessinez vos flux dès le départ.</p></div>
</div>

<p class="fixline">Et validez vos no-go : charge sur l'API, zones, versions des moteurs.</p>

<!--
Repères : trois choses à retenir · identité, rotation, flux · le reste se gère quand on le connaît

- Quotas très bas par défaut : prévoir les demandes de hausse (acceptées sans difficulté).
- Tout ça avant de signer. Faites des POC : Scaleway est ouvert là-dessus.
- Flux : pas de facturation du trafic chez Scaleway, c'est un bon point.
- Si vous n'êtes pas sur Kubernetes, deux options : voir avec Scaleway ce qui est faisable pour vos charges, ou amener vos propres services à la place des services managés. D'autres clients l'ont fait. Ça a un coût d'exploitation.

**Si la question vient : « pourquoi pas un IaaS ? »**
- On amène ce qui vit dans Kubernetes et se rejoue en GitOps : Harbor, l'observabilité, le filtrage Cilium.
- On consomme ce qui demande de l'astreinte sur de l'état : plan de contrôle, etcd, bases, stockage objet, LB.
- Sur un IaaS, tout ce second bloc serait à nous. Pour une équipe infra de 3, ce n'est pas une économie. Et ça ne règle pas l'identité.
-->

---

<p class="eyebrow">Si c'était à refaire</p>
<h1>Si on repartait de zéro</h1>

<div class="cards">
<div><b>Concevoir l'IAM d'abord</b><p>Plus de temps sur le découpage des applications et des permissions, avant tout le reste.</p></div>
<div><b>Moins de clusters, plus gros</b><p>Avec notre couche de sécurité, des clusters mutualisés auraient coûté moins cher.</p></div>
<div><b>Le go/no-go dès le jour 1</b><p>Charge API, zones, réplication des bases : mesurées et validées dès le départ.</p></div>
</div>

<!--
- On a gardé l'architecture GCP pour limiter le risque de la migration. C'était une contrainte de projet légitime.
- Mais en partant de zéro : plus de temps sur le découpage des permissions, et moins de clusters, plus gros.
- **L'argument FinOps (si la question vient) :** un plan de contrôle Kapsule dédié haut de gamme coûte environ 250 € par mois, contre environ 70 € sur GKE. Chaque cluster en plus se paie. Avec Cilium et nos garde-fous IAM, des clusters mutualisés auraient tenu.
- Le go/no-go, on l'a fait avant de signer. Faites-le aussi.
-->

---

<p class="eyebrow">Le bout du chemin</p>
<h1>Ce qui marche bien</h1>

<div class="cards">
<div><b>Le provider Terraform couvre presque tout</b><p>Une organisation entière se reconstruit depuis le code.</p></div>
<div><b>Cilium géré dans Kapsule</b><p>On écrit des policies, on déploie Hubble.</p></div>
<div><b>Secret Manager + External Secrets</b><p>Un vrai cloisonnement par équipe, au chemin.</p></div>
<div><b>Object Storage compatible S3</b><p>Velero, Kopia, caches de CI : sans adaptation.</p></div>
<div><b>PostgreSQL s'abonne à Cloud SQL</b><p>Migration sans coupure longue.</p></div>
<div><b>Cockpit fédéré, VPN BGP vers GCP</b><p>Une seule datasource. Le VPN se décrit en Terraform.</p></div>
</div>

<!--
- Une fois les obstacles levés, ce qui nous a portés, et qui justifie d'y aller. En 30 secondes.
- Scaleway a fait des efforts pour s'intégrer aux outils du marché : External DNS, External Secrets, un provider Crossplane.
-->

---
layout: center
class: text-center
---

<h1>Merci !</h1>
<p class="muted">Une randonnée pas si tranquille, mais on est arrivés.</p>
<p>Questions ?</p>

<div style="display:flex;gap:1.2rem;align-items:center;justify-content:center;margin-top:1.5rem">
<div style="background:#fff;border:1px solid var(--line);border-radius:10px;padding:.8rem"><svg viewBox="0 0 33 33" role="img" aria-label="QR code vers le support du talk" style="width:9rem;height:9rem;display:block"><path stroke="#1f1830" d="M0 0.5h7m1 0h4m1 0h2m1 0h3m3 0h1m1 0h1m1 0h7m-33 1h1m5 0h1m1 0h1m1 0h5m1 0h1m1 0h3m1 0h1m1 0h1m1 0h1m5 0h1m-33 1h1m1 0h3m1 0h1m1 0h1m2 0h1m1 0h2m1 0h1m3 0h3m3 0h1m1 0h3m1 0h1m-33 1h1m1 0h3m1 0h1m2 0h1m1 0h1m2 0h1m1 0h1m1 0h4m2 0h1m1 0h1m1 0h3m1 0h1m-33 1h1m1 0h3m1 0h1m1 0h1m1 0h2m1 0h1m1 0h2m9 0h1m1 0h3m1 0h1m-33 1h1m5 0h1m2 0h11m1 0h1m1 0h1m2 0h1m5 0h1m-33 1h7m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h7m-23 1h2m1 0h1m1 0h2m7 0h1m-25 1h1m2 0h8m3 0h1m2 0h1m7 0h1m2 0h1m1 0h3m-32 1h1m1 0h1m1 0h1m2 0h4m1 0h3m1 0h4m1 0h2m4 0h4m-31 1h3m1 0h2m1 0h2m3 0h1m1 0h2m3 0h7m1 0h5m-33 1h2m5 0h1m1 0h1m1 0h3m1 0h2m1 0h2m4 0h2m1 0h1m2 0h3m-33 1h1m1 0h2m2 0h1m2 0h5m3 0h1m1 0h2m2 0h2m1 0h1m5 0h1m-28 1h1m2 0h4m1 0h2m2 0h4m1 0h2m3 0h1m2 0h1m-31 1h2m3 0h3m1 0h5m1 0h1m1 0h1m1 0h1m6 0h1m-27 1h2m1 0h3m2 0h1m1 0h2m4 0h1m3 0h1m2 0h3m2 0h3m1 0h1m-33 1h1m2 0h5m1 0h1m1 0h1m1 0h1m1 0h1m2 0h1m1 0h1m1 0h2m1 0h5m-30 1h5m3 0h3m1 0h4m1 0h4m1 0h1m2 0h2m1 0h1m1 0h1m1 0h1m-32 1h2m1 0h3m4 0h2m2 0h5m3 0h5m1 0h2m1 0h1m-33 1h1m1 0h1m1 0h2m1 0h1m1 0h1m1 0h1m1 0h2m1 0h1m2 0h1m2 0h1m1 0h2m2 0h3m1 0h1m-33 1h1m1 0h3m1 0h2m2 0h3m3 0h1m1 0h2m3 0h3m3 0h1m1 0h2m-33 1h1m1 0h4m1 0h3m2 0h1m1 0h1m2 0h1m2 0h4m3 0h4m-31 1h1m5 0h3m1 0h2m9 0h1m1 0h1m1 0h2m3 0h3m-33 1h1m1 0h1m2 0h1m2 0h1m2 0h5m1 0h1m1 0h2m3 0h4m2 0h1m1 0h1m-33 1h2m2 0h3m3 0h1m2 0h1m2 0h1m6 0h6m2 0h2m-25 1h3m2 0h5m4 0h1m1 0h1m3 0h1m1 0h2m-32 1h7m1 0h1m1 0h3m2 0h1m1 0h1m1 0h1m1 0h4m1 0h1m1 0h1m1 0h1m-31 1h1m5 0h1m1 0h1m1 0h1m3 0h1m1 0h3m1 0h1m2 0h2m3 0h5m-33 1h1m1 0h3m1 0h1m1 0h1m1 0h4m1 0h3m1 0h2m1 0h7m2 0h1m-32 1h1m1 0h3m1 0h1m1 0h1m1 0h1m3 0h1m1 0h4m4 0h2m1 0h1m1 0h4m-33 1h1m1 0h3m1 0h1m2 0h5m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h1m1 0h3m1 0h2m-33 1h1m5 0h1m2 0h4m5 0h3m2 0h1m3 0h2m1 0h3m-33 1h7m1 0h2m4 0h4m5 0h2m2 0h2"/></svg>
</div>
<p class="muted" style="margin:0;text-align:left;font-family:Archivo,sans-serif">Le support, pour relire :<br><b style="color:var(--accent)">wihrt.github.io/talks/migrer-sur-scaleway</b></p>
</div>

<!--
**Questions probables**
- « Combien ça vous a coûté / fait économiser ? » → le moteur, c'est la souveraineté. Ne jamais citer le contrat.
- « Comment vous avez réglé la latence de l'API ? » → spécifique à notre contexte, voir directement avec Scaleway.
- « Pourquoi pas deux clés en alternance ? » → faisable, on a choisi de ne pas compliquer un manque du provider.
- « Si vous amenez vos services, pourquoi pas un IaaS ? » → on amène ce qui vit dans Kubernetes, on consomme ce qui demande de l'astreinte sur de l'état (plan de contrôle, bases, S3). Voir la note de la slide bilan.
- « Victoria en prod, ça vaut quoi ? » → réponse courte, puis proposer d'en reparler (futur REX). Points prêts : VictoriaLogs a remplacé OpenSearch ; en cluster, VictoriaLogs shard sans répliquer, donc la HA se fait par fan-out de vlagent vers deux instances single-node, avec vmauth pour basculer la lecture. Garder 2 min max.
- « Votre clé CI, c'est le point faible ? » → oui, c'est le joyau : seule l'infra merge sur main, clé masquée et tournée par Terraform.
-->
