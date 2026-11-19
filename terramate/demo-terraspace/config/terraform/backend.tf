# Un backend par stack, dont le chemin dérive des variables d'expansion : plus jamais de copier-coller.
# En vrai : un backend S3 avec key = "<%= expansion(':ENV/:MOD_NAME/terraform.tfstate') %>".
# Pour la démo : un backend local, rangé dans /.state à la racine du projet.
terraform {
  backend "local" {
    path = "<%= Terraspace.root %>/.state/<%= expansion(':ENV/:MOD_NAME') %>/terraform.tfstate"
  }
}
