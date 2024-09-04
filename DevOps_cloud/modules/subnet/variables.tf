variable "vpc_id" {
  description = "The VPC ID where the security group will be created."
  type        = string
}

variable "vpc_rt_id" {
  type        = string
  description = "VPC Routing Table ID"
}

variable "subnet_name" {
  type        = string
  description = "VPC Subnet Name"
}

variable "subnet_cidr_block" {
  type        = string
  description = "VPC Subnet CIDR Block"
  default     = "10.0.10.0/24"
}