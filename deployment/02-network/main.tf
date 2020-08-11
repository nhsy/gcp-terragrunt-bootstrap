###
# Generate random id to append to every created resource name
###

locals {
  vpc_name        = "${var.network_name}-${var.unique_id}"
  subnet_name     = "${var.network_name}-${var.subnet_name}-${var.unique_id}"
  router_name     = "${var.network_name}-${var.router_name}-${var.unique_id}"
  nat_router_name = "${var.network_name}-${var.router_nat_name}-${var.unique_id}"
}

###
# VPC
###

module "vpc" {
  source                  = "terraform-google-modules/network/google//modules/vpc"
  version                 = "~> 2.4.0"
  project_id              = var.project_id
  network_name            = local.vpc_name
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

###
# Subnet
###

module "subnets" {
  source       = "terraform-google-modules/network/google//modules/subnets"
  version      = "~> 2.4.0"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = [
    {
      subnet_name           = local.subnet_name
      subnet_ip             = var.subnet_ip_cidr_range
      subnet_region         = var.region
      subnet_private_access = var.subnet_private_ip_google_access
    }
  ]
}

###
# Cloud Router & NAT config
###

resource "google_compute_router" "compute_router" {
  name    = local.router_name
  project = var.project_id
  region  = var.region
  network = module.vpc.network_self_link

  bgp {
    asn = var.nat_bgp_asn
  }
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 1.3.0"
  name                               = local.nat_router_name
  project_id                         = var.project_id
  router                             = google_compute_router.compute_router.name
  region                             = google_compute_router.compute_router.region
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
}