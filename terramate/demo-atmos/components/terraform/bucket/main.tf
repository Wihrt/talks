variable "environnement" {
  type        = string
  description = "Environnement"
}

variable "organisation" {
  type        = string
  description = "Préfixe de l'organisation"
}

variable "region" {
  type        = string
  description = "Région"
}

variable "nom" {
  type        = string
  description = "Nom court du bucket"
}

variable "subnet_id" {
  type        = string
  description = "Sous-réseau de la zone"
}

variable "versionne" {
  type        = bool
  description = "Active le versioning"
  default     = true
}

resource "terraform_data" "bucket" {
  input = {
    nom       = "${var.organisation}-${var.nom}"
    region    = var.region
    versionne = var.versionne
    subnet_id = var.subnet_id
  }
}

output "bucket" {
  value = terraform_data.bucket.output
}
