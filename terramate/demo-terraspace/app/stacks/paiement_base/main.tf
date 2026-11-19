module "base" {
  source = "../../modules/base_de_donnees"

  nom       = "${local.organisation}-paiement"
  region    = local.region
  subnet_id = var.subnet_id
  taille    = var.taille
}
