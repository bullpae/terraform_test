resource "nhncloud_networking_secgroup_v2" "sg" {
    name = var.sg_name
}

resource "nhncloud_networking_secgroup_rule_v2" "sg_rule" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = var.port_range_min
    port_range_max    = var.port_range_max
    remote_ip_prefix  = var.remote_ip_prefix
    security_group_id = nhncloud_networking_secgroup_v2.sg.id
}