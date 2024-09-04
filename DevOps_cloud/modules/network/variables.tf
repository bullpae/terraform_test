variable "vpc_id" {
  description = "The VPC ID where the security group will be created."
  type        = string
}

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

variable "vpc_igw_name" {
  type        = string
  description = "VPC Internet Gateway Name"
  default     = "devops-vpc-igw"
}

variable "vpc_rt_name" {
  type        = string
  description = "VPC Routing Table Name"
  default     = "devops-vpc-rt"
}

variable "vpc_rt_id" {
  type        = string
  description = "VPC Routing Table ID"
  default     = "devops-vpc-rt-id"
}

variable "subnet_name" {
  type        = string
  description = "VPC Subnet Name"
  default     = "devops-subnet"
}

variable "subnet_cidr_block" {
  type        = string
  description = "VPC Subnet CIDR Block"
  default     = "10.0.10.0/24"
}