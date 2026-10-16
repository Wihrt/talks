# Ce que l'équipe écrit (équivalent de equipes/paiement.tm.yml) :
# des unités du catalogue, avec leurs valeurs. Pas de base ? On supprime le bloc.
locals {
  equipe = "paiement"
  zone   = "paris"
}

unit "stockage" {
  source = "${get_repo_root()}/catalogue/units/stockage"
  path   = "stockage"

  values = {
    equipe = local.equipe
    zone   = local.zone
  }
}

unit "base" {
  source = "${get_repo_root()}/catalogue/units/base"
  path   = "base"

  values = {
    equipe      = local.equipe
    zone        = local.zone
    taille_base = "M"
  }
}
