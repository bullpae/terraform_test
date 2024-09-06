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

    # count = length(var.block_device)

    block_device {
        uuid = ( var.block_device[0].image_type == "linux" ? data.nhncloud_images_image_v2.linux.id : 
          var.block_device[0].image_type == "mariadb" ? data.nhncloud_images_image_v2.linux_db.id : 
          null
        )
        #uuid                  = var.image_id
        source_type           = var.block_device[0].source_type
        destination_type      = var.block_device[0].destination_type
        boot_index            = var.block_device[0].boot_index
        volume_size           = var.block_device[0].volume_size
        delete_on_termination = var.block_device[0].delete_on_termination
    }

    block_device {
        source_type           = var.block_device[1].source_type
        destination_type      = var.block_device[1].destination_type
        boot_index            = var.block_device[1].boot_index
        volume_size           = var.block_device[1].volume_size
        delete_on_termination = var.block_device[1].delete_on_termination
    }
}
