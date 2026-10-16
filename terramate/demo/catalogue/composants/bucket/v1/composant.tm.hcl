# Un composant : une brique d'infra réutilisable, avec ses entrées typées.
define component metadata {
  class       = "demo.io/bucket"
  version     = "1.0.0"
  name        = "Bucket S3"
  description = "Un bucket objet, versionné, au nom normalisé"
}

define component input "nom" {
  type        = string
  description = "Nom court du bucket"
}

define component input "versionne" {
  type        = bool
  description = "Active le versioning"
  default     = true
}

generate_hcl "main.tf" {
  content {
    resource "terraform_data" "bucket" {
      input = {
        nom       = "${global.organisation}-${component.input.nom.value}"
        region    = global.region
        versionne = component.input.versionne.value
      }
    }

    output "bucket" {
      value = terraform_data.bucket.output
    }
  }
}
