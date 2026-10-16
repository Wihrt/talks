# Des workflows nommés, déclarés une fois, lancés partout : terramate script run deploiement
script "previsualisation" {
  description = "init + plan"

  job {
    commands = [
      ["tofu", "init"],
      ["tofu", "plan", "-out=plan.tfplan"],
    ]
  }
}

script "deploiement" {
  description = "init + plan + apply"

  job {
    commands = [
      ["tofu", "init"],
      ["tofu", "plan", "-out=plan.tfplan"],
      ["tofu", "apply", "plan.tfplan"],
    ]
  }
}
