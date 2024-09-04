# variable "vpc_id" {
#   description = "The VPC ID where the security group will be created."
#   type        = string
# }

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

variable "vpc_rt_name" {
  type        = string
  description = "VPC Routing Table Name"
}
