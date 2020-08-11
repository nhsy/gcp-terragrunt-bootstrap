# deployment/02-network
The resources/services that this network layer module will create/trigger are:

- One VPC inside of a project
- One Subnet, with no secondary ranges
- Three custom firewall rules
- One Cloud Router and NAT resource
- Two Cloud DNS forwarding addresses

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.8 |
| google | ~> 3.33.0 |
| google-beta | ~> 3.33.0 |
| random | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.33.0 |
| google-beta | ~> 3.33.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_domain | Zone domain. | `string` | n/a | yes |
| dns\_enable\_inbound\_forwarding | Toggle inbound query forwarding for VPC DNS. | `bool` | `true` | no |
| dns\_enable\_logging | Toggle DNS logging for VPC DNS. | `bool` | `false` | no |
| dns\_zone\_name | DNS zone name. | `string` | n/a | yes |
| nat\_bgp\_asn | BGP router ASN for NAT cloud routes. The value will be fixed for this router resource. | `number` | `64514` | no |
| nat\_ip\_allocate\_option | Value inferred based on nat\_ips. If present set to MANUAL\_ONLY, otherwise AUTO\_ONLY. | `bool` | `false` | no |
| network\_name | The name of the VPC network being created. | `string` | `"citrix-network"` | no |
| project\_id | The project ID to host the network in. | `string` | n/a | yes |
| region | The region to deploy to. | `string` | n/a | yes |
| router\_name | Cloud NAT router name | `string` | `"cr-nat-router"` | no |
| router\_nat\_name | Cloud NAT gateway name | `string` | `"rn-nat-gateway"` | no |
| source\_service\_accounts | A list of service accounts such that the firewall will apply only to traffic originating from an instance with a service account in this list. | `list(string)` | `null` | no |
| source\_subnetwork\_ip\_ranges\_to\_nat | (Optional) Defaults to ALL\_SUBNETWORKS\_ALL\_IP\_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL\_SUBNETWORKS\_ALL\_IP\_RANGES, ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES, LIST\_OF\_SUBNETWORKS. Changing this forces a new NAT to be created. | `string` | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | no |
| subnet\_ip\_cidr\_range | The IP and CIDR range of the subnet being created. | `string` | `"10.0.0.0/20"` | no |
| subnet\_name | The name of the VPC network being created. | `string` | `"private-subnet"` | no |
| subnet\_private\_ip\_google\_access | Whether this subnet will have private Google access enabled. | `string` | `"true"` | no |
| target\_name\_server\_addresses | List of target name servers for forwarding zone. | `list(string)` | n/a | yes |
| target\_service\_accounts | A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allow. | `list(string)` | `null` | no |
| unique\_id | The unique id for this deployment. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The name of the created Cloud NAT instance |
| name\_servers | Zone name servers. |
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| project\_id | VPC project id |
| subnets | The created subnet resources |

