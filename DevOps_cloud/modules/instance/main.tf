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
    # user_data = <<-EOF
    #         #!/bin/bash
    #         dnf update -y
    #         dnf install -y nginx
    #         systemctl start nginx
    #         systemctl enable nginx
    #         cd /var/www/html
    #         wget https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_907aaf97c9764306a937aaebcf1877d0/200lv/lab_9/index.html
    #         wget https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_907aaf97c9764306a937aaebcf1877d0/200lv/lab_9/logo.gif
    #         wget https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_907aaf97c9764306a937aaebcf1877d0/200lv/lab_9/style.css
    #         EOF          

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
