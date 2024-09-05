variable "nic_name" {
  description = "Network Interface Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
}