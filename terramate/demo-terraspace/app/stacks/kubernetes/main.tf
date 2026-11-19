module "cluster" {
  source = "../../modules/cluster"

  nom         = "${local.organisation}-${local.environnement}-k8s"
  region      = local.region
  version_k8s = var.version_k8s
}

# Un bloc par service : une boucle ERB (Ruby) à la place de tm_dynamic.
<%
  services = {
    "api"    => { port: 8080, public: true },
    "worker" => { port: 9090, public: false },
  }
%>
<% services.each do |nom, svc| %>
resource "terraform_data" "<%= nom %>" {
  input = {
    nom   = "${local.organisation}-${local.environnement}-<%= nom %>"
    port  = <%= svc[:port] %>
    acces = "<%= svc[:public] ? 'internet' : 'interne' %>"
    env   = local.environnement
    vpc   = var.vpc_nom
  }
<% if svc[:public] %>
  lifecycle {
    create_before_destroy = true
  }
<% end %>
}

output "<%= nom %>_port" {
  value = <%= svc[:port] %>
}
<% end %>
