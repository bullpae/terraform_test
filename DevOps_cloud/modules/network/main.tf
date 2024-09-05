resource "nhncloud_networking_port_v2" "nic" {
  name = var.nic_name
  network_id = var.vpc_id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = var.subnet_id
  }
  security_group_ids = [var.sg_id]
}