variable "nom" { type = string }
variable "region" { type = string }
variable "subnet_id" { type = string }
variable "taille" {
  type    = string
  default = "S"
}

resource "terraform_data" "base" {
  input = {
    nom     = var.nom
    moteur  = "PostgreSQL-17"
    gabarit = var.taille
    region  = var.region
    subnet  = var.subnet_id
  }
}

output "base" {
  value = terraform_data.base.output
}
