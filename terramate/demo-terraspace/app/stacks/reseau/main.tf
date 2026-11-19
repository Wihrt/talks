resource "terraform_data" "vpc" {
  input = {
    nom    = "${local.organisation}-${local.environnement}-vpc"
    region = local.region
    cidr   = "10.0.0.0/16"
  }
}
