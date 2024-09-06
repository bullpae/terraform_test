# variable "vpc_id" {
#   description = "The VPC ID where the security group will be created."
#   type        = string
# }

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "vpc_rt_names" {
  description = "VPC Routing Table Names"
  type        = list(string)
}
