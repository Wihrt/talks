# Talks

Les supports de mes talks, en [Slidev](https://sli.dev). Un dossier = un talk.

| Talk | Événement |
|---|---|
| [`migrer-sur-scaleway`](./migrer-sur-scaleway) | REX meetup — *Une randonnée pas si tranquille : migrer sur Scaleway* (GCP → Scaleway, 2026) |

## Prérequis

[mise](https://mise.jdx.dev) installe tout le reste : Node et [aube](https://aube.sh) (le gestionnaire de paquets).

```sh
mise trust
mise install
```

## Utilisation

```sh
mise run list                          # liste les talks
mise run dev migrer-sur-scaleway       # Slidev en local, avec rechargement
mise run build migrer-sur-scaleway     # site statique dans dist/migrer-sur-scaleway
mise run export migrer-sur-scaleway    # PDF dans dist/migrer-sur-scaleway.pdf
```

Les dépendances (Slidev, thème, Chromium pour l'export PDF) sont partagées à la racine : `mise run install` (lancé automatiquement par les autres tasks).

## Ajouter un talk

1. Créer un dossier `<nom-du-talk>/` avec un `slides.md`.
2. Optionnel, dans le même dossier : `style.css` (styles du talk), `vite.config.ts`, images référencées en relatif (`./photo.jpg`).
3. `mise run dev <nom-du-talk>`.
