stack {
  name        = "kubernetes"
  description = "Cluster Kubernetes du socle"
  tags        = ["socle", "kubernetes"]
  id          = "2f8e4a90-1b7c-4d2e-8f3a-5c6d7e8f9a02"

  # Le réseau d'abord : Terramate ordonne l'exécution.
  after = ["tag:reseau"]
}
