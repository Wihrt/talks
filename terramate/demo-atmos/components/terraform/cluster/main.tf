variable "organisation" { type = string }
variable "environnement" { type = string }
variable "region" { type = string }
variable "version_k8s" { type = string }
variable "vpc_id" { type = string }

# Module local, partagé : il vit hors du dossier du composant.
module "cluster" {
  source = "../../../modules/cluster"

  nom         = "${var.organisation}-${var.environnement}-k8s"
  region      = var.region
  version_k8s = var.version_k8s
  vpc_id      = var.vpc_id
}

output "cluster" {
  value = module.cluster.cluster
}
