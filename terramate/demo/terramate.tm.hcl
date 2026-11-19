terramate {
  required_version = "~> 0.17"

  config {
    # Les scripts sont encore une fonctionnalité expérimentale.
    experiments = ["scripts"]

    git {
      default_branch = "main"
    }

    run {
      env {
        # Injecté dans chaque commande lancée par terramate run.
        TF_INPUT = "0"
      }
    }
  }
}
