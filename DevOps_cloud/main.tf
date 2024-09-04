module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "devops-vpc" 
  vpc_cidr_block = "10.0.0.0/16"
  vpc_rt_name    = "devops-vpc-rt"
}

module "dev_subnet" {
  source = "./modules/subnet"
  subnet_name = "devops-subnet"
  vpc_id = module.vpc.vpc_id
  vpc_rt_id = module.vpc.vpc_rt_id
}

module "test_subnet" {
  source = "./modules/subnet"
  subnet_name = "test-subnet"
  vpc_id = module.vpc.vpc_id
  vpc_rt_id = module.vpc.vpc_rt_id
}

module "dev_security_group" {
  source = "./modules/scurity_group"
  sg_name = "devops-sg"
  port_range_min = 80
  port_range_max = 80
  remote_ip_prefix = "0.0.0.0/0"
}

# 공인 IP 할당 (internet gateway 가 연결된 VPC에만 할당 가능!! 현재는 VPC Default Network만 자동 가능!!)
resource "nhncloud_networking_floatingip_v2" "fip" {
    pool = "Public Network"
}