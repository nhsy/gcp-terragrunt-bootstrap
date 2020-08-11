###
# VPC
###

output "project_id" {
  value       = module.vpc.project_id
  description = "VPC project id"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

###
# Subnet
###

output "subnets" {
  value       = module.subnets
  description = "The created subnet resources"
}

###
# Cloud NAT
###

output "name" {
  description = "The name of the created Cloud NAT instance"
  value       = module.cloud-nat.name
}

###
# Cloud DNS
###

output "name_servers" {
  description = "Zone name servers."
  value       = module.dns-forwarding-zone.name_servers
}