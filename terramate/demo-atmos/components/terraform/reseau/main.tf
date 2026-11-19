variable "organisation" { type = string }
variable "environnement" { type = string }
variable "region" { type = string }

resource "terraform_data" "vpc" {
  input = {
    nom    = "${var.organisation}-${var.environnement}-vpc"
    region = var.region
    cidr   = "10.0.0.0/16"
  }
}

output "vpc" {
  value = terraform_data.vpc.output
}

output "vpc_id" {
  value = "vpc-${var.organisation}-${var.environnement}"
}
