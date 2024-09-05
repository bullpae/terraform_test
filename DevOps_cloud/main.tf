module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "devops-vpc"
  vpc_cidr_block = "10.0.0.0/16"
  vpc_rt_name    = "devops-vpc-rt"
}

module "subnet" {
  source = "./modules/subnet"
  count  = length(var.subnet_zones)

  subnet_name       = "${var.subnet_zones[count.index]}-subnet"
  vpc_id            = module.vpc.vpc_id
  vpc_rt_id         = module.vpc.vpc_rt_id
  subnet_cidr_block = "10.0.${(count.index + 1) * 10}.0/24"
}

module "security_group" {
  source = "./modules/security_group"
  count  = length(var.sg_sg_rules)

  sg_name  = var.sg_sg_rules[count.index].sg_name
  sg_rules = var.sg_sg_rules[count.index].sg_rules # list type
}

# module "network" {
#   source = "./modules/network"

#   nic_name = "devpos-nic"
#   vpc_id   = module.vpc.vpc_id
#   subnet_id = module.subnet[0].subnet_id
#   sg_id    = module.security_group[0].sg_id
# }

module "instance" {
  source = "./modules/instance"
  count  = length(var.instances)

  # Network Interface
  vpc_id    = module.vpc.vpc_id
  # nic_id    = module.network.nic_id
  subnet_id = module.subnet[var.instances[count.index].subnet_index].subnet_id
  sg_id     = module.security_group[var.instances[count.index].sg_index].sg_id
  nic_name      = var.instances[count.index].nic_name

  # Instance VM
  instance_name = var.instances[count.index].instance_name
  key_pair      = var.instances[count.index].key_pair
  flavor_id     = data.nhncloud_compute_flavor_v2.devops_flavor.id
  image_id      = data.nhncloud_images_image_v2.linux.id
  block_device  = var.instances[count.index].block_device
}


# # 공인 IP 할당 (internet gateway 가 연결된 VPC에만 할당 가능!! 현재는 VPC Default Network만 자동 가능!!)
# resource "nhncloud_networking_floatingip_v2" "fip" {
#     pool = "Public Network"
# }

# # 공인 IP 할당
# resource "nhncloud_networking_floatingip_associate_v2" "devops-fip_associate" {
#     floating_ip = nhncloud_networking_floatingip_v2.devops-fip.address
#     port_id = nhncloud_networking_port_v2.devops-nic.id
# }