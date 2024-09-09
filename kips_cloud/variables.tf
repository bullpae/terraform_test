variable "vpc_info" {
  type = list(object({
    vpc_name       = string
    vpc_cidr_block = string
    vpc_rt_names   = list(string)
  }))

  default = [{ vpc_name = "koiia-vpc"
    vpc_cidr_block = "10.1.0.0/16"
    vpc_rt_names   = ["public-koiia-vpc-rt", "private-koiia-vpc-rt"]
  }]
}

# variable "vpc_cidr_block" {
#   type    = list(string)
#   default = ["10.1.0.0/16"]
# }

# variable "vpc_rt_name" {
#   type    = list(string)
#   default = ["public-koiia-vpc-rt", "private-koiia-vpc-rt"]
# }

variable "subnet_zones" {
  type = list(object({
    subnet_name = string
    vpc_index   = number
    subnet_type = string
  }))
  default = [{
    subnet_name = "web-subnet" # 10.1.10.0/24
    vpc_index   = 0
    subnet_type = "public"
    }, {
    subnet_name = "was-subnet" # 10.1.20.0/24
    vpc_index   = 0
    subnet_type = "private"
    }, {
    subnet_name = "db-subnet" # 10.1.30.0/24
    vpc_index   = 0
    subnet_type = "private"
    }, {
    subnet_name = "test-subnet" # 10.1.40.0/24
    vpc_index   = 0
    subnet_type = "private"
    }, {
    subnet_name = "dev-subnet" # 10.1.50.0/24
    vpc_index   = 0
    subnet_type = "private"
  }]
  #default = ["web", "test", "dev"]
}

# variable "vpc_index" {
#   type = number
# }

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
        from_port   = "22" # 보안을 위해 Port 변경 필요!
        to_port     = "22" # 보안을 위해 Port 변경 필요!
        protocol    = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }]
    },
    {
      sg_name = "was-sg"
      sg_rules = [{
        name        = "tomcat"
        description = "tomcat"
        ethertype   = "IPv4"
        direction   = "ingress"
        from_port   = "8080"
        to_port     = "8080"
        protocol    = "tcp"
        cidr_blocks = "10.1.10.0/24" # web-subnet 허용
        },
        {
          name        = "ssh"
          description = "ssh"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "22"
          to_port     = "22"
          protocol    = "tcp"
          cidr_blocks = "10.1.10.0/24" # web-subnet 허용 (bastion)
      }]
    },
    {
      sg_name = "db-sg"
      sg_rules = [{
        name        = "mariadb"
        description = "mariadb"
        ethertype   = "IPv4"
        direction   = "ingress"
        from_port   = "3306"
        to_port     = "3306"
        protocol    = "tcp"
        cidr_blocks = "10.1.20.0/24" # was-subnet 허용 
        },
        {
          name        = "ssh"
          description = "ssh"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "22"
          to_port     = "22"
          protocol    = "tcp"
          cidr_blocks = "10.1.10.0/24" # web-subnet 허용 (bastion)
      }]
    },
    {
      sg_name = "test-sg"
      sg_rules = [{
        name        = "tomcat"
        description = "tomcat"
        ethertype   = "IPv4"
        direction   = "ingress"
        from_port   = "8080"
        to_port     = "8080"
        protocol    = "tcp"
        cidr_blocks = "10.1.10.0/24" # web-subnet 허용
        },
        {
          name        = "mariadb"
          description = "mariadb"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "3306"
          to_port     = "3306"
          protocol    = "tcp"
          cidr_blocks = "10.1.40.0/24" # test-subnet 허용
        },
        {
          name        = "ssh"
          description = "ssh"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "22"
          to_port     = "22"
          protocol    = "tcp"
          cidr_blocks = "10.1.10.0/24" # web-subnet 허용 (bastion)
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
        cidr_blocks = "10.1.10.0/24" # web-subnet 허용
        },
        {
          name        = "tomcat"
          description = "tomcat"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "80"
          to_port     = "80"
          protocol    = "tcp"
          cidr_blocks = "10.1.50.0/24" # dev-subnet 허용
        },
        {
          name        = "mariadb"
          description = "mariadb"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "3306"
          to_port     = "3306"
          protocol    = "tcp"
          cidr_blocks = "10.1.50.0/24" # dev-subnet 허용
        },
        {
          name        = "ssh"
          description = "ssh"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "22"
          to_port     = "22"
          protocol    = "tcp"
          cidr_blocks = "10.1.10.0/24" # web-subnet 허용 (bastion)
      }]
    },
    {
      sg_name = "waf-sg"
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
          name        = "https"
          description = "https"
          ethertype   = "IPv4"
          direction   = "ingress"
          from_port   = "443"
          to_port     = "443"
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
    subnet_index  = number # web=0, was=1, db=2, test=3, dev=4 
    sg_index      = number # web-sg=0, was-sg=1, db-sg=2, test-sg=3, dev-sg=4, waf-sg=5
    key_pair      = string
    flavor_id     = string
    block_device = list(object({
      image_type            = string
      source_type           = string
      destination_type      = string
      boot_index            = number
      volume_size           = number
      delete_on_termination = bool
    }))
  }))

  default = [{
    instance_name = "bastion_vm"
    nic_name      = "bastion_nic"
    subnet_index  = 0
    sg_index      = 0
    key_pair      = "koiia_msp_key"
    flavor_id     = "bastion"
    block_device = [{
      image_type            = "linux"
      source_type           = "image"
      destination_type      = "volume"
      boot_index            = 0
      volume_size           = 50
      delete_on_termination = true
      },
      {
        image_type            = ""
        source_type           = "blank"
        destination_type      = "volume"
        boot_index            = 1
        volume_size           = 50
        delete_on_termination = true
    }] },
    {
      instance_name = "waf_vm"
      nic_name      = "waf_nic"
      subnet_index  = 0
      sg_index      = 0
      key_pair      = "koiia_msp_key"
      flavor_id     = "waf"
      block_device = [{
        image_type            = "penta_waf"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 200
        delete_on_termination = true
        },
        {
          image_type            = ""
          source_type           = "blank"
          destination_type      = "volume"
          boot_index            = 1
          volume_size           = 1000
          delete_on_termination = true
    }] },
    {
      instance_name = "analysis_test_web_vm"
      nic_name      = "analysis_test_web_nic"
      subnet_index  = 0
      sg_index      = 0
      key_pair      = "koiia_msp_key"
      flavor_id     = "web"
      block_device = [{
        image_type            = "linux"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
        },
        {
          image_type            = ""
          source_type           = "blank"
          destination_type      = "volume"
          boot_index            = 1
          volume_size           = 100
          delete_on_termination = true
    }] },
    {
      instance_name = "analysis_test_was_vm"
      nic_name      = "analysis_test_was_nic"
      subnet_index  = 3
      sg_index      = 3
      key_pair      = "koiia_msp_key"
      flavor_id     = "was"
      block_device = [{
        image_type            = "linux"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
        },
        {
          image_type            = ""
          source_type           = "blank"
          destination_type      = "volume"
          boot_index            = 1
          volume_size           = 500
          delete_on_termination = true
    }] },
    {
      instance_name = "analysis_test_db_vm"
      nic_name      = "analysis_test_db_nic"
      subnet_index  = 3
      sg_index      = 3
      key_pair      = "koiia_msp_key"
      flavor_id     = "db"
      block_device = [{
        image_type            = "mariadb"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
        },
        {
          image_type            = ""
          source_type           = "blank"
          destination_type      = "volume"
          boot_index            = 1
          volume_size           = 500
          delete_on_termination = true
    }] },
    {
      instance_name = "analysis_dev_was_vm"
      nic_name      = "analysis_dev_was_nic"
      subnet_index  = 4
      sg_index      = 4
      key_pair      = "koiia_msp_key"
      flavor_id     = "was"
      block_device = [{
        image_type            = "linux"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
        },
        {
          image_type            = ""
          source_type           = "blank"
          destination_type      = "volume"
          boot_index            = 1
          volume_size           = 500
          delete_on_termination = true
    }] },
    {
      instance_name = "map_dev_db_vm"
      nic_name      = "map_dev_db_nic"
      subnet_index  = 4
      sg_index      = 4
      key_pair      = "koiia_msp_key"
      flavor_id     = "db"
      block_device = [{
        image_type            = "mariadb"
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 50
        delete_on_termination = true
        },
        {
          image_type            = ""
          source_type           = "blank"
          destination_type      = "volume"
          boot_index            = 1
          volume_size           = 500
          delete_on_termination = true
  }] }]
}
