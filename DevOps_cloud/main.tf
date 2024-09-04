module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "devops-vpc" 
  vpc_cidr_block = "10.0.0.0/16"
  vpc_rt_name    = "devops-vpc-rt"
}



module "dev_subnet" {
  source = "./modules/subnet"
  count = length(var.subnet_zones)

  subnet_name = "${var.subnet_zones[count.index]}-subnet"
  vpc_id = module.vpc.vpc_id
  vpc_rt_id = module.vpc.vpc_rt_id
  subnet_cidr_block = "10.0.${(count.index+1) * 10}.0/24"
}

module "dev_security_group" {
  source = "./modules/security_group"
  count = length(var.sg_sg_rules)

  sg_name = var.sg_sg_rules[count.index].sg_name
  sg_rules = var.sg_sg_rules[count.index].sg_rules
  # sg_name = var.sg_rules[count.index].sg_name 
  # direction = var.sg_rules[count.index].sg_rule[count.index].direction
  # ethertype = var.sg_rule[count.index].ethertype
  # protocol = var.sg_rules[count.index].protocol
  # port_range_min = var.sg_rules[count.index].from_port
  # port_range_max = var.sg_rules[count.index].to_port
  # remote_ip_prefix = var.sg_rules[count.index].cidr_blocks
}

# 공인 IP 할당 (internet gateway 가 연결된 VPC에만 할당 가능!! 현재는 VPC Default Network만 자동 가능!!)
resource "nhncloud_networking_floatingip_v2" "fip" {
    pool = "Public Network"
}