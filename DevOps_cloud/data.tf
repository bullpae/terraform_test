data "nhncloud_compute_flavor_v2" "devops-flavor" {
  name = "m2.c4m8"
}

data "nhncloud_networking_vpc_v2" "default-vpc" {
  name = "Default Network"
}

data "nhncloud_networking_vpcsubnet_v2" "default-subnet" {
  name = "Default Network"
}

data "nhncloud_images_image_v2" "linux" {
  name = var.image_desc
  most_recent = true
}
