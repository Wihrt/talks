module "cluster" {
  source = "../../../modules/cluster"

  nom         = "${local.organisation}-${local.environnement}-k8s"
  region      = local.region
  version_k8s = "1.34"
}

output "cluster" {
  value = module.cluster.cluster
}
