# Une zone réseau partagée, portée par la plateforme. Les équipes s'y rattachent.
define bundle metadata {
  class       = "demo.io/zone"
  version     = "1.0.0"
  name        = "Zone réseau"
  description = "Un sous-réseau partagé, que les espaces d'équipe référencent"
}

define bundle input "nom" {
  type        = string
  description = "Nom de la zone"
  prompt {
    text = "Nom de la zone"
  }
}

define bundle input "cidr" {
  type        = string
  description = "Plage d'adresses du sous-réseau"
  default     = "10.0.1.0/24"
  prompt {
    text = "Plage CIDR"
  }
}

# Sans alias, il vaudrait « <dossier>:<nom> » : on veut « paris ».
define bundle {
  alias = bundle.input.nom.value
}

# Ce que la zone expose aux autres bundles.
define bundle export "subnet_id" {
  description = "Identifiant du sous-réseau"
  value       = "subnet-${bundle.input.nom.value}"
}

define bundle export "cidr" {
  description = "Plage d'adresses de la zone"
  value       = bundle.input.cidr.value
}

define bundle stack "zone" {
  metadata {
    path  = "/stacks/socle/zones/${bundle.input.nom.value}"
    name  = "zone-${bundle.input.nom.value}"
    tags  = ["socle", "zone"]
    after = ["tag:reseau"]
  }

  component "zone" {
    source = "/catalogue/composants/zone/v1"
    inputs {
      nom  = bundle.input.nom.value
      cidr = bundle.input.cidr.value
    }
  }
}
