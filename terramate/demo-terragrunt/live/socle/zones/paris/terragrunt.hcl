# La zone partagée, portée par la plateforme (équivalent de plateforme/zone-paris.tm.yml).
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/zone"
}

dependency "reseau" {
  config_path  = "../../reseau"
  skip_outputs = true # ordre seulement, aucune sortie consommée
}

inputs = {
  nom  = "paris"
  cidr = "10.0.1.0/24"
}
