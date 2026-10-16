module "bucket" {
  source = "../../modules/bucket"

  nom       = "${local.organisation}-paiement-donnees"
  region    = local.region
  subnet_id = var.subnet_id
}
