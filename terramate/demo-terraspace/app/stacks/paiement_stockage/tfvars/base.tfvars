# Le subnet_id vient de la stack zone (l'export de la zone paris).
subnet_id = <%= output("zone.subnet_id", mock: "subnet-mock") %>
# Ordre seul, sans valeur échangée : l'équivalent de after = ["tag:kubernetes"].
<% depends_on("kubernetes") %>
