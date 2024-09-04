
output "subnet_id" {
  value = nhncloud_networking_vpcsubnet_v2.subnet.id
}

output "fip_address" {
    value = nhncloud_networking_floatingip_v2.fip.address    
}
