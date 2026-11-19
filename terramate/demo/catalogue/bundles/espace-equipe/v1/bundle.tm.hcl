# Un bundle : ce qu'une équipe demande. Il assemble des composants en stacks.
define bundle metadata {
  class       = "demo.io/espace-equipe"
  version     = "1.0.0"
  name        = "Espace d'équipe"
  description = "Le stockage et la base d'une équipe produit"
}

define bundle input "equipe" {
  type        = string
  description = "Nom de l'équipe"
  prompt {
    text = "Nom de l'équipe"
  }
}

define bundle input "zone" {
  type        = bundle("demo.io/zone")
  description = "Zone réseau de l'équipe"
  prompt {
    text = "Zone réseau"
  }
}

define bundle input "base" {
  type        = bool
  description = "L'équipe a besoin d'une base PostgreSQL"
  default     = false
  prompt {
    text = "Une base PostgreSQL ?"
  }
}

define bundle input "taille_base" {
  type        = string
  description = "Gabarit de la base"
  default     = "S"
  prompt {
    text    = "Gabarit de la base"
    options = ["S", "M", "L"]
  }
}

# Où le développeur range son fichier quand il passe par terramate ui / scaffold.
define bundle scaffolding {
  path = "/equipes/${bundle.input.equipe.value}.tm.yml"
  name = bundle.input.equipe.value
}

define bundle stack "stockage" {
  metadata {
    path  = "/stacks/equipes/${bundle.input.equipe.value}/stockage"
    name  = "${bundle.input.equipe.value}-stockage"
    tags  = ["equipe", bundle.input.equipe.value]
    after = ["tag:kubernetes", "tag:zone"]
  }

  component "bucket" {
    source = "/catalogue/composants/bucket/v1"
    inputs {
      nom       = "${bundle.input.equipe.value}-donnees"
      subnet_id = bundle.input.zone.value.export.subnet_id.value
    }
  }
}

define bundle stack "base" {
  condition = bundle.input.base.value

  metadata {
    path  = "/stacks/equipes/${bundle.input.equipe.value}/base"
    name  = "${bundle.input.equipe.value}-base"
    tags  = ["equipe", bundle.input.equipe.value]
    after = ["tag:reseau", "tag:zone"]
  }

  component "base" {
    source = "/catalogue/composants/base-de-donnees/v1"
    inputs {
      nom       = bundle.input.equipe.value
      taille    = bundle.input.taille_base.value
      subnet_id = bundle.input.zone.value.export.subnet_id.value
    }
  }
}
