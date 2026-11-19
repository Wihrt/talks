output "vpc" {
  value = terraform_data.vpc.output
}

output "vpc_nom" {
  value = terraform_data.vpc.output.nom
}
