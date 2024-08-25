resource "nhncloud_networking_secgroup_v2" "tf-sg" {
    name = "tf-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "tf-sg-rule" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = nhncloud_networking_secgroup_v2.tf-sg.id
}

resource "nhncloud_networking_port_v2" "nic" {
  name = "tf_port_1"
  network_id = data.nhncloud_networking_vpc_v2.vpc.id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = data.nhncloud_networking_vpcsubnet_v2.subnet.id
  }
  security_group_ids = [nhncloud_networking_secgroup_v2.tf-sg.id]
}

resource "nhncloud_networking_floatingip_v2" "fip" {
    pool = "Public Network"
}

resource "nhncloud_networking_floatingip_associate_v2" "fipa" {
    floating_ip = nhncloud_networking_floatingip_v2.fip.address
    port_id = nhncloud_networking_port_v2.nic.id
}

resource "nhncloud_compute_instance_v2" "instance" {
    name      = "failover"
    key_pair  = "tf_key"
    flavor_id = data.nhncloud_compute_flavor_v2.t2c1m1.id
    user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y nginx
            systemctl start nginx
            systemctl enable nginx
            cd /var/www/html
            wget https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_907aaf97c9764306a937aaebcf1877d0/200lv/lab_9/index.html
            wget https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_907aaf97c9764306a937aaebcf1877d0/200lv/lab_9/logo.gif
            wget https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_907aaf97c9764306a937aaebcf1877d0/200lv/lab_9/style.css
            EOF            

    network {        
        port = nhncloud_networking_port_v2.nic.id        
    }    

    block_device {
        uuid                  = data.nhncloud_images_image_v2.ubuntu.id
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 20
        delete_on_termination = true
    }
}

output "fip_address" {
    value = nhncloud_networking_floatingip_v2.fip.address    
}