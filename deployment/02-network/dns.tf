###
# Cloud DNS - Forwarding Zone.
###

resource "google_dns_policy" "default_policy" {
  provider                  = google-beta
  project                   = var.project_id
  name                      = "default-policy"
  enable_inbound_forwarding = var.dns_enable_inbound_forwarding
  enable_logging            = var.dns_enable_logging
  networks {
    network_url = module.vpc.network_self_link
  }
}

module "dns-forwarding-zone" {
  source     = "terraform-google-modules/cloud-dns/google"
  version    = "~> 3.0.2"
  project_id = var.project_id
  type       = "forwarding"
  name       = var.dns_zone_name
  domain     = var.dns_domain

  private_visibility_config_networks = [module.vpc.network_self_link]
  target_name_server_addresses       = var.target_name_server_addresses
}
