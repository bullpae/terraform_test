# internet Gateway 생성
resource "nhncloud_vpc_internet_gateway" "igw" {
  name = var.vpc_igw_name
  vpc_id = var.vpc_id
}

# routing table 생성
resource "nhncloud_networking_routingtable_v2" "vpc_rt" {
  name = var.vpc_rt_name
  vpc_id = var.vpc_id
  distributed = true
}

# subnet 생성
resource "nhncloud_networking_vpcsubnet_v2" "subnet" {
  name      = var.subnet_name
  vpc_id    = var.vpc_id
  cidr      = var.subnet_cidr_block
  routingtable_id = var.vpc_rt_id
}

# 공인 IP 할당 (internet gateway 가 연결된 VPC에만 할당 가능!! 현재는 VPC Default Network만 자동 가능!!)
resource "nhncloud_networking_floatingip_v2" "fip" {
    pool = "Public Network"
}
