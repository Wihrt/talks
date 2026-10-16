# Copié dans chaque stack : les valeurs communes + les métadonnées de la stack.
locals {
  organisation  = "demo"
  region        = "fr-par"
  environnement = "<%= Terraspace.env %>"
  stack         = "<%= expansion(':MOD_NAME') %>"
}
