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