nom     = "paris"
cidr    = "10.0.1.0/24"
vpc_nom = <%= output("reseau.vpc_nom", mock: "demo-mock-vpc") %>
