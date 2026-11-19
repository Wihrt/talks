# Valeurs héritées par toutes les stacks. Une stack ou un dossier peut les surcharger.
globals {
  organisation  = "demo"
  proprietaire  = "plateforme"
  region        = "fr-par"
  environnement = "prod"

  tofu_version = "~> 1.10"
}

import {
  source = "/imports/*.tm.hcl"
}
