variable "sg_name" {
  type        = string
  description = "Security Group Name"
}

# variable "direction" {
#   type        = string
#   description = "Direction(ingress or egress)"
# }

# variable "ethertype" {
#   type        = string
#   description = "Ethertype(IPv4 or IPv6)"
# }

# variable "protocol" {
#   type        = string
#   description = "Port Range Min"
# }

# variable "port_range_min" {
#   type        = string
#   description = "Port Range Min"
# }

# variable "port_range_max" {
#   type        = string
#   description = "Port Range Max"
# }

# variable "remote_ip_prefix" {
#   type        = string
#   description = "Remote IP Prefix(cidr block)"
# }

variable "sg_rules" {
  description = "Security Group Rules"
  type        = list(object({
      name        = string
      description = string
      ethertype   = string
      direction   = string
      from_port   = string
      to_port     = string
      protocol    = string
      cidr_blocks = string
  }))
}
