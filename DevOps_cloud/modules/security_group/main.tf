resource "nhncloud_networking_secgroup_v2" "sg" {
    name = var.sg_name
}

resource "nhncloud_networking_secgroup_rule_v2" "sg_rule" {
    count = length(var.sg_rules)

    direction         = var.sg_rules[count.index].direction
    ethertype         = var.sg_rules[count.index].ethertype
    protocol          = var.sg_rules[count.index].protocol
    port_range_min    = var.sg_rules[count.index].from_port
    port_range_max    = var.sg_rules[count.index].to_port
    remote_ip_prefix  = var.sg_rules[count.index].cidr_blocks
    security_group_id = nhncloud_networking_secgroup_v2.sg.id
}