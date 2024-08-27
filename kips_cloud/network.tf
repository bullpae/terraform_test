# network.tf
  
# vpc 생성
resource "nhncloud_networking_vpc_v2" "kips-vpc" {
  name = "kips-vpc"
  cidrv4 = "10.0.0.0/16"
}

# routing table 생성
resource "nhncloud_networking_routingtable_v2" "kips-vpc-rt" {
  name = "kips-vpc-rt"
  vpc_id = nhncloud_networking_vpc_v2.kips-vpc.id
  distributed = true
  #internet_gw_id = var.web-ig
}

# subnet 생성
resource "nhncloud_networking_vpcsubnet_v2" "web-subnet" {
  name      = "web-subnet"
  vpc_id    = nhncloud_networking_vpc_v2.kips-vpc.id
  cidr      = "10.0.1.0/24"
  routingtable_id = nhncloud_networking_routingtable_v2.kips-vpc-rt.id
}

resource "nhncloud_networking_vpcsubnet_v2" "was-subnet" {
  name      = "was-subnet"
  vpc_id    = nhncloud_networking_vpc_v2.kips-vpc.id
  cidr      = "10.0.2.0/24"
  routingtable_id = nhncloud_networking_routingtable_v2.kips-vpc-rt.id
}

resource "nhncloud_networking_vpcsubnet_v2" "db-subnet" {
  name      = "db-subnet"
  vpc_id    = nhncloud_networking_vpc_v2.kips-vpc.id
  cidr      = "10.0.3.0/24"
  routingtable_id = nhncloud_networking_routingtable_v2.kips-vpc-rt.id
}

resource "nhncloud_networking_vpcsubnet_v2" "dev-subnet" {
  name      = "dev-subnet"
  vpc_id    = nhncloud_networking_vpc_v2.kips-vpc.id
  cidr      = "10.0.4.0/24"
  routingtable_id = nhncloud_networking_routingtable_v2.kips-vpc-rt.id
}

data "nhncloud_networking_vpcsubnet_v2" "default-subnet" {
  name = "Default Network"
}

# 공인 IP 할당
resource "nhncloud_networking_floatingip_v2" "web-fip" {
    pool = "Public Network"
}

resource "nhncloud_networking_floatingip_v2" "bastion-fip" {
    pool = "Public Network"
}