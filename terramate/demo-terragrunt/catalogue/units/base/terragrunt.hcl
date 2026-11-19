# Unité du catalogue : la base PostgreSQL d'une équipe.
# try() : sans `values` (le fichier du catalogue, hors stack), la config reste lisible
# par Terragrunt, qui la parse pendant --filter-affected.
locals {
  equipe      = try(values.equipe, "exemple")
  zone        = try(values.zone, "paris")
  taille_base = try(values.taille_base, "S")
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/base-de-donnees"
}

dependency "zone" {
  config_path = "${get_repo_root()}/live/socle/zones/${local.zone}"

  mock_outputs                            = { subnet_id = "subnet-mock" }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
}

dependencies {
  paths = ["${get_repo_root()}/live/socle/reseau"]
}

inputs = {
  nom       = local.equipe
  taille    = local.taille_base
  subnet_id = dependency.zone.outputs.subnet_id
}
