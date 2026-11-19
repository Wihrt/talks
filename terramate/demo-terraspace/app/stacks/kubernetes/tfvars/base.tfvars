# L'ordre : vpc_nom vient de la stack reseau. output() ajoute la dépendance (kubernetes après reseau).
version_k8s = "1.34"
vpc_nom     = <%= output("reseau.vpc_nom", mock: "demo-mock-vpc") %>
