# security_group.tf 

# 보안 그룹 생성
# DevOps
resource "nhncloud_networking_secgroup_v2" "devops-sg" {
    name = "devops-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "devops-sg-rule-01" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 80
    port_range_max    = 80
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = nhncloud_networking_secgroup_v2.devops-sg.id
}

