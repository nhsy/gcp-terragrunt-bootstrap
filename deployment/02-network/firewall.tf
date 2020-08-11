###
# Firewall rules
###

module "network-firewall" {
  source     = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  version    = "~> 2.4.0"
  project_id = var.project_id
  network    = module.vpc.network_name

  custom_rules = {
    allow-all-citrix-interconnectivity-sa = {
      description          = "Allow all traffic from citrix sa instances"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = null
      use_service_accounts = true
      sources              = var.source_service_accounts
      targets              = var.target_service_accounts
      rules = [
        {
          protocol = "all"
          ports    = null # all ports
        }
      ]
      extra_attributes = {
        priority = 30
      }
    }
    iap-rdp = {
      description          = "Allow RDP via IAP when using the SA for Windows workloads"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = data.google_netblock_ip_ranges.iap_forwarders.cidr_blocks_ipv4
      use_service_accounts = true
      sources              = null
      targets              = var.target_service_accounts
      rules = [
        {
          protocol = "tcp"
          ports = [
          "3389"]
        }
      ]
      extra_attributes = {
        priority = 65534
      }
    }
    allow-ssh = {
      description          = "Allow SSH to machines"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = null
      use_service_accounts = true
      sources              = null
      targets              = var.target_service_accounts
      rules = [
        {
          protocol = "tcp"
          ports = [
          "22"]
        }
      ]
      extra_attributes = {
        priority = 65534
      }
    }
  }
}
