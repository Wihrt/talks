define component metadata {
  class       = "demo.io/base-de-donnees"
  version     = "1.0.0"
  name        = "Base PostgreSQL"
  description = "Une base PostgreSQL managée, sauvegardée"
}

define component input "nom" {
  type        = string
  description = "Nom de la base"
}

define component input "taille" {
  type        = string
  description = "Gabarit de l'instance"
  default     = "S"
}

generate_hcl "main.tf" {
  content {
    resource "terraform_data" "base" {
      input = {
        nom     = "${global.organisation}-${component.input.nom.value}"
        moteur  = "PostgreSQL-17"
        gabarit = component.input.taille.value
        region  = global.region
      }
    }

    output "base" {
      value = terraform_data.base.output
    }
  }
}
