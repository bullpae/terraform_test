# data.tf
# 미리 만들어두어야 할 리소스
# Key Pair : kips_key.pem

data "nhncloud_compute_flavor_v2" "t2c1m1"{
  name = "t2.c1m1"
}

# data "nhncloud_networking_vpc_v2" "kips-vpc" {
#   name = "kips-vpc"
# }

# data "nhncloud_networking_vpcsubnet_v2" "web-subnet" {
#   name = "web-subnet"
# }

# data "nhncloud_networking_vpcsubnet_v2" "was-subnet" {
#   name = "was-subnet"
# }

# data "nhncloud_networking_vpcsubnet_v2" "db-subnet" {
#   name = "db-subnet"
# }

# data "nhncloud_networking_vpcsubnet_v2" "dev-subnet" {
#   name = "dev-subnet"
# }

data "nhncloud_images_image_v2" "linux" {
  name = var.image_desc
  most_recent = true
}

