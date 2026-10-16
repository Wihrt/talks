variable "region" {
  type        = string
  description = "Région"
}

variable "environnement" {
  type        = string
  description = "Environnement"
}

variable "organisation" {
  type        = string
  description = "Préfixe de l'organisation"
}

variable "nom" {
  type        = string
  description = "Nom de la zone"
}

variable "cidr" {
  type        = string
  description = "Plage d'adresses du sous-réseau"
  default     = "10.0.1.0/24"
}

resource "terraform_data" "zone" {
  input = {
    nom  = "${var.organisation}-${var.nom}"
    cidr = var.cidr
  }
}

output "zone" {
  value = terraform_data.zone.output
}

# Ce que la zone expose aux autres unités.
output "subnet_id" {
  value = "subnet-${var.nom}"
}

output "cidr" {
  value = var.cidr
}
