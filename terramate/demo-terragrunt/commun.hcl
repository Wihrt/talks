# Valeurs partagées par toutes les unités (l'équivalent de globals.tm.hcl).
# Lues par root.hcl avec read_terragrunt_config : pas d'héritage automatique, c'est explicite.
locals {
  organisation  = "demo"
  proprietaire  = "plateforme"
  region        = "fr-par"
  environnement = "prod"

  tofu_version = "~> 1.10"
}
