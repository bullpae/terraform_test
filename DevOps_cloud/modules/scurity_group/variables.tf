variable "sg_name" {
  type        = string
  description = "Security Group Name"
}

variable "port_range_min" {
  type        = string
  description = "Port Range Min"
}

variable "port_range_max" {
  type        = string
  description = "Port Range Max"
}

variable "remote_ip_prefix" {
  type        = string
  description = "Remote IP Prefix"
}
