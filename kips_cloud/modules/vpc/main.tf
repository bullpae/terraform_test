# vpc 생성
resource "nhncloud_networking_vpc_v2" "vpc" {
  name = var.vpc_name
  cidrv4 = var.vpc_cidr_block
}

# routing table 생성
resource "nhncloud_networking_routingtable_v2" "vpc_rt" {
  name = var.vpc_rt_name  # 입력 받을 변수
  vpc_id = nhncloud_networking_vpc_v2.vpc.id
  distributed = true
}
