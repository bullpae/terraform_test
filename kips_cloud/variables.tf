variable "vpc_name" {
  type    = string
  default = "kips-vpc"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_rt_name" {
  type    = string
  default = "kips-vpc-rt"
}

variable "subnet_zones" {
  type    = list(string)
  default = ["web", "test", "dev"]
}

variable "sg_sg_rules" {
  description = "Security Group & Security Group Rules"
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
    sg_name = "web-sg"
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
    },
    {
      sg_name = "dev-sg"
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
    subnet_index  = number # web=0, test=1, dev=2 ## was 추가 시 index 주의!!
    sg_index      = number # web-sg=0, test-sg=1, dev-sg=2
    key_pair      = string
    flavor_id     = string
    block_device = object({
      image_id              = string
      source_type           = string
      destination_type      = string
      boot_index            = number
      volume_size           = number
      delete_on_termination = bool
    })
  }))

  default = [{
    instance_name = "bastion_vm"
    nic_name      = "bastion_nic"
    subnet_index  = 0
    sg_index      = 0
    key_pair      = "kips_key"
    flavor_id     = "bastion"
    block_device = {
      image_id              = "os"
      source_type           = "image"
      destination_type      = "volume"
      boot_index            = 0
      volume_size           = 50
      delete_on_termination = true
    } },
    {
      instance_name = "analysis_test_web_vm"
      nic_name      = "analysis_test_web_nic"
      subnet_index  = 0
      sg_index      = 0
      key_pair      = "kips_key"
      flavor_id     = "web"
      block_device = {
        image_id              = "os"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
    } },
    {
      instance_name = "analysis_test_was_vm"
      nic_name      = "analysis_test_was_nic"
      subnet_index  = 1
      sg_index      = 1
      key_pair      = "kips_key"
      flavor_id     = "was"
      block_device = {
        image_id              = "os"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
    } },
    {
      instance_name = "analysis_test_db_vm"
      nic_name      = "analysis_test_db_nic"
      subnet_index  = 1
      sg_index      = 1
      key_pair      = "kips_key"
      flavor_id     = "db"
      block_device = {
        image_id              = "os"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
    } },
    {
      instance_name = "analysis_dev_was_vm"
      nic_name      = "analysis_dev_was_nic"
      subnet_index  = 2
      sg_index      = 2
      key_pair      = "kips_key"
      flavor_id     = "was"
      block_device = {
        image_id              = "os"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
    } },
    {
      instance_name = "map_dev_db_vm"
      nic_name      = "map_dev_db_nic"
      subnet_index  = 2
      sg_index      = 2
      key_pair      = "kips_key"
      flavor_id     = "db"
      block_device = {
        image_id              = "os"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
  } }]
}
