define component metadata {
  class       = "demo.io/zone"
  version     = "1.0.0"
  name        = "Zone réseau"
  description = "Un sous-réseau privé dans le VPC du socle"
}

define component input "nom" {
  type        = string
  description = "Nom de la zone"
}

define component input "cidr" {
  type        = string
  description = "Plage d'adresses du sous-réseau"
}

generate_hcl "main.tf" {
  content {
    resource "terraform_data" "zone" {
      input = {
        nom  = "${global.organisation}-${component.input.nom.value}"
        cidr = component.input.cidr.value
      }
    }

    output "zone" {
      value = terraform_data.zone.output
    }
  }
}
