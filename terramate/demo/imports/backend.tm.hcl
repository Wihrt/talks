# Un backend par stack, dont la clé dérive du chemin : plus jamais de copier-coller.
# En vrai : un backend S3 avec key = terramate.stack.path.relative.
# Pour la démo : un backend local, rangé dans /.state à la racine du repo.
generate_hcl "_terramate_backend.tf" {
  lets {
    vers_racine = tm_join("/", [for _ in tm_split("/", terramate.stack.path.relative) : ".."])
  }

  content {
    terraform {
      required_version = global.tofu_version

      backend "local" {
        path = "${let.vers_racine}/.state/${terramate.stack.path.relative}/terraform.tfstate"
      }
    }
  }
}
