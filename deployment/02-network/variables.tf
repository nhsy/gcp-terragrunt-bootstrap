###
# VPC - REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
###

variable "project_id" {
  type        = string
  description = "The project ID to host the network in."
}

variable "region" {
  type        = string
  description = "The region to deploy to."
}

variable "unique_id" {
  type        = string
  description = "The unique id for this deployment."
}

###
# VPC - OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
###

variable "network_name" {
  type        = string
  description = "The name of the VPC network being created."
  default     = "citrix-network"
}

###
# Subnet - OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
###

variable "subnet_name" {
  type        = string
  description = "The name of the VPC network being created."
  default     = "private-subnet"
}

variable "subnet_ip_cidr_range" {
  type        = string
  description = "The IP and CIDR range of the subnet being created."
  default     = "10.0.0.0/20"
}

variable "subnet_private_ip_google_access" {
  type        = string
  description = "Whether this subnet will have private Google access enabled."
  default     = "true"
}

###
# Firewall - REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
###

variable "source_service_accounts" {
  type        = list(string)
  description = "A list of service accounts such that the firewall will apply only to traffic originating from an instance with a service account in this list."
  default     = null
}

variable "target_service_accounts" {
  type        = list(string)
  description = "A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allow."
  default     = null
}

###
# Cloud Router & NAT config - OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
###

variable "router_name" {
  type        = string
  description = "Cloud NAT router name"
  default     = "cr-nat-router"
}

variable "router_nat_name" {
  type        = string
  description = "Cloud NAT gateway name"
  default     = "rn-nat-gateway"
}

variable "nat_ip_allocate_option" {
  type        = bool
  description = "Value inferred based on nat_ips. If present set to MANUAL_ONLY, otherwise AUTO_ONLY."
  default     = false
}

variable "nat_bgp_asn" {
  type        = number
  description = "BGP router ASN for NAT cloud routes. The value will be fixed for this router resource."
  default     = 64514
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type        = string
  description = "(Optional) Defaults to ALL_SUBNETWORKS_ALL_IP_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS. Changing this forces a new NAT to be created."
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

###
# Cloud DNS - REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
###

variable "dns_zone_name" {
  type        = string
  description = "DNS zone name."
}

variable "dns_domain" {
  type        = string
  description = "Zone domain."
}

variable "target_name_server_addresses" {
  type        = list(string)
  description = "List of target name servers for forwarding zone."
}

###
# Cloud DNS - OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
###

variable "dns_enable_inbound_forwarding" {
  type        = bool
  description = "Toggle inbound query forwarding for VPC DNS."
  default     = true
}

variable "dns_enable_logging" {
  type        = bool
  description = "Toggle DNS logging for VPC DNS."
  default     = false
}