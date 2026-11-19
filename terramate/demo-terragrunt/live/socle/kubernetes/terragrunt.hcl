include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Le module local. Un changement dans modules/cluster concerne cette unité.
terraform {
  source = "${get_repo_root()}/modules/cluster"
}

# Le réseau d'abord : Terragrunt ordonne l'exécution, et passe la sortie vpc_id.
dependency "reseau" {
  config_path = "../reseau"

  # Pour plan/validate avant que le réseau existe.
  mock_outputs                            = { vpc_id = "vpc-mock" }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
}

inputs = {
  nom         = "demo-prod-k8s"
  version_k8s = "1.34"
  vpc_id      = dependency.reseau.outputs.vpc_id
}
