variable "nom" { type = string }
variable "region" { type = string }
variable "version_k8s" { type = string }

resource "terraform_data" "cluster" {
  input = {
    nom     = var.nom
    region  = var.region
    version = var.version_k8s
  }
}

output "cluster" {
  value = terraform_data.cluster.output
}
