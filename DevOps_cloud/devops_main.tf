# kips_main.tf

# Network Interface 생성
resource "nhncloud_networking_port_v2" "devops-nic" {
  name = "devops_port"
  network_id = data.nhncloud_networking_vpc_v2.default-vpc.id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = data.nhncloud_networking_vpcsubnet_v2.default-subnet.id
  }
  security_group_ids = [nhncloud_networking_secgroup_v2.web-sg.id]
}

# 공인 IP 할당
resource "nhncloud_networking_floatingip_associate_v2" "devops-fip_associate" {
    floating_ip = nhncloud_networking_floatingip_v2.devops-fip.address
    port_id = nhncloud_networking_port_v2.devops-nic.id
}

# DevOps 서버 인스턴스 생성
resource "nhncloud_compute_instance_v2" "devops-instance" {
    name      = "devops-server"
    key_pair  = "devops_key"
    flavor_id = data.nhncloud_compute_flavor_v2.devops-flavor.id

    network {        
        port = nhncloud_networking_port_v2.devops-nic.id        
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