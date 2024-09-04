# # internet Gateway 생성
# resource "nhncloud_vpc_internet_gateway" "igw" {
#   name = var.vpc_igw_name
#   vpc_id = var.vpc_id
# }

# # routing table 생성
# resource "nhncloud_networking_routingtable_v2" "vpc_rt" {
#   name = var.vpc_rt_name  # 입력 받을 변수
#   vpc_id = var.vpc_id
#   distributed = true
# }

# subnet 생성
resource "nhncloud_networking_vpcsubnet_v2" "subnet" {
  name      = var.subnet_name  # 입력 받을 변수
  vpc_id    = var.vpc_id
  cidr      = var.subnet_cidr_block
  routingtable_id = var.vpc_rt_id  # 입력 받을 변수
}



# # Network Interface 생성
# resource "nhncloud_networking_port_v2" "devops-nic" {
#   name = "devops_port"
#   network_id = data.nhncloud_networking_vpc_v2.default-vpc.id
#   admin_state_up = "true"
#   fixed_ip {
#     subnet_id = data.nhncloud_networking_vpcsubnet_v2.default-subnet.id
#   }
#   security_group_ids = [nhncloud_networking_secgroup_v2.devops-sg.id]
# }

# # 공인 IP 할당
# resource "nhncloud_networking_floatingip_associate_v2" "devops-fip_associate" {
#     floating_ip = nhncloud_networking_floatingip_v2.devops-fip.address
#     port_id = nhncloud_networking_port_v2.devops-nic.id
# }