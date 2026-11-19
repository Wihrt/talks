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
  description = "Nom de la base"
}

variable "subnet_id" {
  type        = string
  description = "Sous-réseau de la zone"
}

variable "taille" {
  type        = string
  description = "Gabarit de l'instance"
  default     = "S"
}

resource "terraform_data" "base" {
  input = {
    nom     = "${var.organisation}-${var.nom}"
    moteur  = "PostgreSQL-17"
    gabarit = var.taille
    region  = var.region
    subnet  = var.subnet_id
  }
}

output "base" {
  value = terraform_data.base.output
}
