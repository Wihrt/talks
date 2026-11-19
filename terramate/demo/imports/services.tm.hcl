# Un bloc par service, depuis une map de globals : tm_dynamic fait la boucle.
generate_hcl "_terramate_services.tf" {
  # Seulement la stack kubernetes.
  stack_filter {
    project_paths = ["/stacks/socle/kubernetes"]
  }

  lets {
    prefixe = "${global.organisation}-${global.environnement}"
  }

  assert {
    assertion = tm_length(global.services) > 0
    message   = "Aucun service déclaré"
  }

  content {
    tm_dynamic "resource" {
      for_each = global.services
      iterator = svc
      labels   = ["terraform_data", svc.key]

      content {
        input = {
          nom   = "${let.prefixe}-${svc.key}"
          port  = svc.value.port
          acces = tm_ternary(svc.value.public, "internet", "interne")
          env   = tm_hcl_expression("local.environnement")
        }

        tm_dynamic "lifecycle" {
          condition = svc.value.public

          content {
            create_before_destroy = true
          }
        }
      }
    }

    tm_dynamic "output" {
      for_each = global.services
      iterator = svc
      labels   = ["${svc.key}_port"]

      attributes = {
        value = svc.value.port
      }
    }
  }
}
