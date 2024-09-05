variable "nhn_user_name" {
  description = "nhncloud account"
  type        = string
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - 테넌트 ID
variable "api_tenant_id" {
  description = "Tenant ID"
  type        = string
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - API 비밀번호 설정
variable "api_password" {
  description = "API Password"
  type        = string
}

variable "api_identity" {
  description = "api identity url:"
  type        = string
  default     = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
}

variable "subnet_zones" {
  type    = list(string)
  default = ["devpos", "test"]
}

variable "sg_sg_rules" {
  type = list(object({
    sg_name = string
    sg_rules = list(object({
      name        = string
      description = string
      ethertype   = string
      direction   = string
      from_port   = string
      to_port     = string
      protocol    = string
      cidr_blocks = string
    }))
  }))

  default = [{
    sg_name = "devops-sg"
    sg_rules = [{
      name        = "http"
      description = "http"
      ethertype   = "IPv4"
      direction   = "ingress"
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      },
      {
        name        = "ssh"
        description = "ssh"
        ethertype   = "IPv4"
        direction   = "ingress"
        from_port   = "22"
        to_port     = "22"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }]
    },
    {
      sg_name = "test-sg"
      sg_rules = [{
        name        = "http"
        description = "http"
        ethertype   = "IPv4"
        direction   = "ingress"
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
        },
        {
          name        = "ssh"
          description = "ssh"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "22"
          to_port     = "22"
          protocol    = "tcp"
          cidr_blocks = "0.0.0.0/0"
      }]
  }]

}

data "nhncloud_compute_flavor_v2" "devops_flavor" {
  name = "m2.c4m8"
}

# locals {
#   devops_flavor_id = data.nhncloud_compute_flavor_v2.devops_flavor.id
# }

data "nhncloud_images_image_v2" "linux" {
  name        = "Rocky Linux 8.10 (2024.08.20)"
  most_recent = true
}

# locals {
#   linux_image_id = data.nhncloud_images_image_v2.linux.id
# }

variable "instances" {
  description = "instance information"
  type = list(object({
    instance_name = string
    nic_name      = string
    subnet_index  = number
    sg_index      = number
    key_pair      = string
    #flavor_id     = string
    block_device = object({
      #uuid                  = string
      source_type           = string
      destination_type      = string
      boot_index            = number
      volume_size           = number
      delete_on_termination = bool
    })
  }))

  default = [{
    instance_name = "devops_vm"
    nic_name      = "devops_nic"
    subnet_index  = 0
    sg_index      = 0
    key_pair      = "devops_key"
    #flavor_id     = local.devops_flavor_id
    block_device = {
      #uuid                  = local.linux_image_id
      source_type           = "image"
      destination_type      = "volume"
      boot_index            = 0
      volume_size           = 20
      delete_on_termination = true
    } },
    {
      instance_name = "test_vm"
      nic_name      = "test_nic"
      subnet_index  = 1
      sg_index      = 1
      key_pair      = "devops_key"
      #flavor_id     = local.devops_flavor_id
      block_device = {
        #uuid                  = local.linux_image_id
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 20
        delete_on_termination = true
  } }]
}
