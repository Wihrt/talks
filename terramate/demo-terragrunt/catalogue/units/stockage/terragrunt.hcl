# Unité du catalogue : le stockage d'une équipe. Les valeurs arrivent par `values`
# (terragrunt.values.hcl, écrit par `stack generate`).
# try() : sans `values` (le fichier du catalogue, hors stack), la config reste lisible
# par Terragrunt, qui la parse pendant --filter-affected.
locals {
  equipe = try(values.equipe, "exemple")
  zone   = try(values.zone, "paris")
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/bucket"
}

# Le subnet_id vient de la sortie de la zone. Le lien ordonne aussi l'exécution.
dependency "zone" {
  config_path = "${get_repo_root()}/live/socle/zones/${local.zone}"

  mock_outputs                            = { subnet_id = "subnet-mock" }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
}

# Ordre seulement (Terramate : after = ["tag:kubernetes"]).
dependencies {
  paths = ["${get_repo_root()}/live/socle/kubernetes"]
}

inputs = {
  nom       = "${local.equipe}-donnees"
  subnet_id = dependency.zone.outputs.subnet_id
}
