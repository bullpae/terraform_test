# network.tf
  
# vpc 생성
# resource "nhncloud_networking_vpc_v2" "kips-vpc" {
#   name = "kips-vpc"
#   cidrv4 = "10.0.0.0/16"
# }

# routing table 생성
resource "nhncloud_networking_routingtable_v2" "devops-vpc-rt" {
  name = "devops-vpc-rt"
  vpc_id = data.nhncloud_networking_vpc_v2.default-vpc.id
  distributed = true
  #internet_gw_id = var.web-ig
}

# subnet 생성
resource "nhncloud_networking_vpcsubnet_v2" "debops-subnet" {
  name      = "devops-subnet"
  vpc_id    = data.nhncloud_networking_vpc_v2.default-vpc.id
  cidr      = "10.0.1.0/24"
  routingtable_id = nhncloud_networking_routingtable_v2.devops-vpc-rt.id
}

# 공인 IP 할당 (internet gateway 가 연결된 VPC에만 할당 가능!! 현재는 VPC Default Network만 자동 가능!!)
resource "nhncloud_networking_floatingip_v2" "devops-fip" {
    pool = "Public Network"
}
