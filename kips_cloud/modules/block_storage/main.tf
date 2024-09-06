# HDD 타입의 빈 블록 스토리지 생성
resource "nhncloud_blockstorage_volume_v2" "volume" {
  name = var.volume_name # "tf_volume_01"
  size = var.volume_size # 10
  availability_zone = var.availability_zone # "kr-pub-a", "kr-pub-b"
  volume_type = var.volume_type # "General HDD", "General SSD"
}

# 블록 스토리지 연결
resource "nhncloud_compute_volume_attach_v2" "volume_to_instance"{
  instance_id = var.instance_id # nhncloud_compute_instance_v2.tf_instance_02.id
  volume_id = nhncloud_blockstorage_volume_v2.volume.id
  vendor_options {
    ignore_volume_confirmation = true
  }
}