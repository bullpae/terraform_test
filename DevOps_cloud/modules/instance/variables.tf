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

# variable "nic_id" {
#   description = "Network Interface ID"
#   type        = string
# }

variable "instance_name" {
  description = "Instance Name"
  type        = string
}

variable "key_pair" {
  description = "Key pair"
  type        = string
}

variable "flavor_id" {
  description = "Flavor ID"
  type        = string
}

variable "image_id" {
  description = "Instance Image ID"
  type        = string
}

variable "block_device" {
  description = "Network Interface ID"
  type        = object({
        #uuid                  = string 
        source_type           = string # image or blank
        destination_type      = string # local or volume
        boot_index            = number # 0(root), etc(additional disk)
        volume_size           = number # GB
        delete_on_termination = bool # instance 삭제시 함께 삭제 유무
  })
}
 