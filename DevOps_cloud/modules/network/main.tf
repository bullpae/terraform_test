# Network Interface 생성
resource "nhncloud_networking_port_v2" "nic" {
  name = var.nic_name  # 입력 변수
  network_id = var.vpc_id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = var.subnet_id
  }
  security_group_ids = [nhncloud_networking_secgroup_v2.devops-sg.id]
}

# 공인 IP 할당
# resource "nhncloud_networking_floatingip_associate_v2" "devops-fip_associate" {
#     floating_ip = nhncloud_networking_floatingip_v2.devops-fip.address
#     port_id = nhncloud_networking_port_v2.devops-nic.id
# }