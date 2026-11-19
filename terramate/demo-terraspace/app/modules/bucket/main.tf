variable "nom" { type = string }
variable "region" { type = string }
variable "subnet_id" { type = string }
variable "versionne" {
  type    = bool
  default = true
}

resource "terraform_data" "bucket" {
  input = {
    nom       = var.nom
    region    = var.region
    versionne = var.versionne
    subnet_id = var.subnet_id
  }
}

output "bucket" {
  value = terraform_data.bucket.output
}
