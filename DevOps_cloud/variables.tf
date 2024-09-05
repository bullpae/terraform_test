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
