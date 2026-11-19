# Les globals deviennent des locals Terraform, avec les métadonnées de la stack.
generate_hcl "_terramate_locals.tf" {
  content {
    locals {
      organisation  = global.organisation
      region        = global.region
      environnement = global.environnement
      stack         = terramate.stack.name
    }
  }
}
