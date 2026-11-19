resource "terraform_data" "zone" {
  input = {
    nom  = "${local.organisation}-${var.nom}"
    cidr = var.cidr
    vpc  = var.vpc_nom
  }
}
