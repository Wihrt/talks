# Racine incluse par toutes les unités : backend, génération de code, entrées communes.
locals {
  commun = read_terragrunt_config("${get_repo_root()}/commun.hcl").locals
}

terraform_binary = "tofu"

# Un backend par unité, dont le chemin dérive de l'emplacement : plus de copier-coller.
# En vrai : un backend S3 avec key = "${path_relative_to_include()}/terraform.tfstate".
# Pour la démo : un backend local, rangé dans /.state à la racine du repo.
# ETAT_DEMO l'épingle à un chemin absolu : avec --filter-affected, Terragrunt exécute les
# unités dans un worktree git temporaire (/tmp), où un .state relatif au repo serait vide.
remote_state {
  backend = "local"

  generate = {
    path      = "_terragrunt_backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    path = "${get_env("ETAT_DEMO", "${get_repo_root()}/.state")}/${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "versions" {
  path      = "_terragrunt_versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOT
    terraform {
      required_version = "${local.commun.tofu_version}"
    }
  EOT
}

# Les valeurs communes arrivent dans les variables de chaque module.
inputs = {
  organisation  = local.commun.organisation
  region        = local.commun.region
  environnement = local.commun.environnement
}
