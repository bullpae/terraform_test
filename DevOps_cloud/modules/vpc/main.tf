# vpc 생성
resource "nhncloud_networking_vpc_v2" "vpc" {
  name = var.vpc_name
  cidrv4 = var.vpc_cidr_block
}
