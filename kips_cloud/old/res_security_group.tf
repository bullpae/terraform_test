# security_group.tf 

# 보안 그룹 생성
# Bastion
resource "nhncloud_networking_secgroup_v2" "bastion-sg" {
    name = "bastion-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "bastion-sg-rule-01" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = nhncloud_networking_secgroup_v2.web-sg.id
}

# WEB
resource "nhncloud_networking_secgroup_v2" "web-sg" {
    name = "web-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "web-sg-rule-01" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 80
    port_range_max    = 80
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = nhncloud_networking_secgroup_v2.web-sg.id
}

# WAS
resource "nhncloud_networking_secgroup_v2" "was-sg" {
    name = "was-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "was-sg-rule-01" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 8080
    port_range_max    = 8080
    remote_ip_prefix  = "10.0.0.0/16"
    security_group_id = nhncloud_networking_secgroup_v2.was-sg.id
}

resource "nhncloud_networking_secgroup_rule_v2" "was-sg-rule-02" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "10.0.0.0/16"
    security_group_id = nhncloud_networking_secgroup_v2.was-sg.id
}

# DB
resource "nhncloud_networking_secgroup_v2" "db-sg" {
    name = "db-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "db-sg-rule-01" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 3306
    port_range_max    = 3306
    remote_ip_prefix  = "10.0.0.0/16"
    security_group_id = nhncloud_networking_secgroup_v2.db-sg.id
}

resource "nhncloud_networking_secgroup_rule_v2" "db-sg-rule-02" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "10.0.0.0/16"
    security_group_id = nhncloud_networking_secgroup_v2.db-sg.id
}

# DEV
resource "nhncloud_networking_secgroup_v2" "dev-sg" {
    name = "dev-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "dev-sg-rule-01" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "10.0.0.0/16"
    security_group_id = nhncloud_networking_secgroup_v2.dev-sg.id
}
