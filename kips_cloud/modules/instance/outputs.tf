
output "instance_id" {
  value = nhncloud_compute_instance_v2.instance.id
}

output "instance_name" {
  value = nhncloud_compute_instance_v2.instance.name
}

# Block Storage 는 Zone 을 알아야 붙일 수 있으므로 필요함!!
# output "block_storage_zone" {
#   value = = nhncloud_blockstorage_volume_v2.volume.zone
# }

