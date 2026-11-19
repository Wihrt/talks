# Un fichier qui n'est pas du HCL : la fiche Backstage de chaque stack, en YAML.
generate_file "catalog-info.yaml" {
  content = tm_yamlencode({
    apiVersion = "backstage.io/v1alpha1"
    kind       = "Component"
    metadata = {
      name        = terramate.stack.name
      description = terramate.stack.description
      annotations = { "terramate.io/path" = terramate.stack.path.absolute }
    }
    spec = {
      type  = "infrastructure"
      owner = global.proprietaire
    }
  })
}
