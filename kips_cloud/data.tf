
# Instance Type
## Standard
### t2.c1m1 : vCPU 1, Memory 1GB
### m2.c1m2 : vCPU 1, Memory 2GB
### m2.c2m4 : vCPU 2, Memory 4GB
### m2.c4m8 : vCPU 4, Memory 8GB
### m2.c8m16 : vCPU 8, Memory 16GB
### m2.c16m32 : vCPU 16, Memory 32GB
## Compute Optimized
### c2.c2m2 : vCPU 2, Memory 2GB
## Memory Optimized
### r2.c8m64 : vCPU 8, Memory 64GB
## Performance Optimized
### x1.c16m128 : vCPU 16, Memory 128GB
data "nhncloud_compute_flavor_v2" "bastion_flavor" {
  name = "m2.c4m8"
}

data "nhncloud_compute_flavor_v2" "web_flavor" {
  name = "m2.c8m16"
}

data "nhncloud_compute_flavor_v2" "was_flavor" {
  name = "x1.c16m128"
}

data "nhncloud_compute_flavor_v2" "db_flavor" {
  name = "r2.c8m64"
}

variable "flavor" {
  description = "flaver type"
  type        = list(string)
  default     = ["bastion", "web", "was", "db"]
}

# data "nhncloud_blockstorage_volume_v2" "default_volume" {
#   name = "ssd_volume1"
#   status = "available"
# }

# OS Image
# Rocky : Rocky Linux 8.10 (2024.08.20)
# Ubuntu : Ubuntu Server 20.04.6 LTS (2024.08.20)
# Centos : CentOS 7.9 (2024.08.20)
# Debian 11 Bullseye : Debian 11.10 Bullseye (2024.08.20)
# Debian 12 Bookworm : Debian 12.6 Bookworm (2024.08.20)
data "nhncloud_images_image_v2" "linux" {
  name        = "CentOS 7.9 (2024.08.20)"
  most_recent = true
}

# Application Image
# CentOS with MariaDB : CentOS 7.9 with MariaDB 10.11.7 (2024.04.23)
# Ubuntu with MariaDB : Ubuntu Server 20.04.6 LTS with MariaDB 10.11.7 (2024.04.23)
data "nhncloud_images_image_v2" "linux_db" {
  name        = "CentOS 7.9 with MariaDB 10.11.7 (2024.04.23)"
  most_recent = true
}

variable "image" {
  description = "vm image"
  type        = list(string)
  default     = ["linux", "mariadb"]
}
