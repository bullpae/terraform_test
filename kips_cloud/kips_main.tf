# kips_main.tf

# Network Interface 생성
resource "nhncloud_networking_port_v2" "web-nic" {
  name = "web_port_1"
  network_id = nhncloud_networking_vpc_v2.kips-vpc.id
  admin_state_up = "true"
  # fixed_ip {
  #   subnet_id = data.nhncloud_networking_vpcsubnet_v2.web-subnet.id
  # }
  security_group_ids = [nhncloud_networking_secgroup_v2.web-sg.id]
}

# resource "nhncloud_networking_floatingip_associate_v2" "fip_associate" {
#     floating_ip = nhncloud_networking_floatingip_v2.web-fip.address
#     port_id = nhncloud_networking_port_v2.web-nic.id
# }

# web 서버 인스턴스 생성
resource "nhncloud_compute_instance_v2" "web-instance" {
    name      = "web-server"
    key_pair  = "kips_key"
    flavor_id = data.nhncloud_compute_flavor_v2.t2c1m1.id

    network {        
        port = nhncloud_networking_port_v2.web-nic.id        
    }    

    block_device {
        uuid                  = data.nhncloud_images_image_v2.linux.id
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 20
        delete_on_termination = true
    }
}

# Network Interface 생성
resource "nhncloud_networking_port_v2" "was-nic" {
  name = "was_port_1"
  network_id = nhncloud_networking_vpc_v2.kips-vpc.id
  admin_state_up = "true"
  security_group_ids = [nhncloud_networking_secgroup_v2.was-sg.id]
}

# was 서버 인스턴스 생성
resource "nhncloud_compute_instance_v2" "was-instance" {
    name      = "was-server"
    key_pair  = "kips_key"
    flavor_id = data.nhncloud_compute_flavor_v2.t2c1m1.id

    network {        
        port = nhncloud_networking_port_v2.was-nic.id        
    }    

    block_device {
        uuid                  = data.nhncloud_images_image_v2.linux.id
        source_type           = "image"
        destination_type      = "volume"
        boot_index            = 0
        volume_size           = 20
        delete_on_termination = true
    }
}
