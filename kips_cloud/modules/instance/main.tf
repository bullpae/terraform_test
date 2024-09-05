resource "nhncloud_networking_port_v2" "nic" {
  name = var.nic_name
  network_id = var.vpc_id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = var.subnet_id
  }
  security_group_ids = [var.sg_id]
}

resource "nhncloud_compute_instance_v2" "instance" {
    name      = var.instance_name
    key_pair  = var.key_pair
    flavor_id = var.flavor_id

    network {        
        # port = var.nic_id    
        port = nhncloud_networking_port_v2.nic.id 
    }    

    block_device {
        uuid                  = var.image_id
        source_type           = var.block_device.source_type
        destination_type      = var.block_device.destination_type
        boot_index            = var.block_device.boot_index
        volume_size           = var.block_device.volume_size
        delete_on_termination = var.block_device.delete_on_termination
    }
}
