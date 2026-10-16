# Les services du cluster : la source de vérité du générateur _terramate_services.tf.
globals {
  services = {
    api    = { port = 8080, public = true }
    worker = { port = 9090, public = false }
  }
}
