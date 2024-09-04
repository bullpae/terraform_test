# variable "vpc_id" {
#   description = "The VPC ID where the security group will be created."
#   type        = string
# }

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "devops-vpc"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}
