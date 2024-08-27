data "nhncloud_compute_flavor_v2" "t2c1m1"{
  name = "t2.c1m1"
}

data "nhncloud_networking_vpc_v2" "vpc" {
  name = "Default Network"
}

data "nhncloud_networking_vpcsubnet_v2" "subnet" {
  name = "Default Network"
}

data "nhncloud_images_image_v2" "ubuntu" {
  name = var.image_desc
  most_recent = true
}
