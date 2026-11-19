output "zone" {
  value = terraform_data.zone.output
}

# Ce que la zone expose aux autres stacks (l'« export » du bundle).
output "subnet_id" {
  value = "subnet-${var.nom}"
}

output "cidr" {
  value = var.cidr
}
