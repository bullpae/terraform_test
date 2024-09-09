# VPC -> Subnet -> Security Group -> Network Interface -> Instance VM

module "vpc" {
  source = "./modules/vpc"
  count  = length(var.vpc_info)

  vpc_name       = var.vpc_info[count.index].vpc_name
  vpc_cidr_block = var.vpc_info[count.index].vpc_cidr_block
  vpc_rt_names   = var.vpc_info[count.index].vpc_rt_names
  # vpc_cidr_block = var.vpc_cidr_block
  # vpc_rt_name    = var.vpc_rt_name
}

module "subnet" {
  source = "./modules/subnet"
  count  = length(var.subnet_zones)

  subnet_name = var.subnet_zones[count.index].subnet_name
  #vpc_id            = module.vpc.vpc_id
  #vpc_rt_id         = module.vpc.vpc_rt_id

  #vpc_index = var.subnet_zones[count.index].vpc_index
  vpc_id = module.vpc[var.subnet_zones[count.index].vpc_index].vpc_id
  # subnet type에 따라 routing table 적용(public=0, private=1)
  vpc_rt_id = (
    var.subnet_zones[count.index].subnet_type == "public" ? module.vpc[var.subnet_zones[count.index].vpc_index].vpc_rts[0].id :
    module.vpc[var.subnet_zones[count.index].vpc_index].vpc_rts[1].id
  )

  # Multi VPC 일 경우 2번째 byte로 구분 (Index + 1)
  # Multi Subnet일 경우 3번째 byte로 구분 (Index + 1) * 10
  subnet_cidr_block = "10.${var.subnet_zones[count.index].vpc_index + 1}.${(count.index + 1) * 10}.0/24"
}

module "security_group" {
  source = "./modules/security_group"
  count  = length(var.sg_sg_rules)

  sg_name = var.sg_sg_rules[count.index].sg_name
  #var.sg_sg_rules[count.index].cidr_blocks = "10.0.${(count.index + 1) * 10}.0/24"
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
  vpc_id = module.vpc[0].vpc_id
  #vpc_id = module.vpc.vpc_id
  # nic_id    = module.network.nic_id
  subnet_id = module.subnet[var.instances[count.index].subnet_index].subnet_id
  sg_id     = module.security_group[var.instances[count.index].sg_index].sg_id
  nic_name  = var.instances[count.index].nic_name

  # Instance VM
  instance_name = var.instances[count.index].instance_name
  key_pair      = var.instances[count.index].key_pair

  #flavor_id     = data.nhncloud_compute_flavor_v2.flavor.id
  flavor_id = (
    var.instances[count.index].flavor_id == "bastion" ? data.nhncloud_compute_flavor_v2.bastion_flavor.id :
    var.instances[count.index].flavor_id == "web" ? data.nhncloud_compute_flavor_v2.web_flavor.id :
    var.instances[count.index].flavor_id == "was" ? data.nhncloud_compute_flavor_v2.was_flavor.id :
    var.instances[count.index].flavor_id == "db" ? data.nhncloud_compute_flavor_v2.db_flavor.id :
    var.instances[count.index].flavor_id == "waf" ? data.nhncloud_compute_flavor_v2.db_flavor.id :
    null
  )

  #image_id      = data.nhncloud_images_image_v2.linux.id


  # image_id = (
  #   var.instances[count.index].block_device.image_id == "linux" ? data.nhncloud_images_image_v2.linux.id :
  #   var.instances[count.index].block_device.image_id == "mariadb" ? data.nhncloud_images_image_v2.linux_db.id :
  #   var.instances[count.index].block_device.image_id == "" ? "" :
  #   null
  # )
  block_device = var.instances[count.index].block_device
}

# module "block_storage" {
#   source = "./modules/block_storage"
#   count  = length(var.instances)

#   instance_id = module.instance[count.index].instance_id

#   volume_size = (module.instance[count.index].instance_name == "bastion_vm" ? 50 : 
#     module.instance[count.index].instance_name == "analysis_test_web_vm" ? 100 : 
#     module.instance[count.index].instance_name == "analysis_test_was_vm" ? 500 : 
#     module.instance[count.index].instance_name == "analysis_test_db_vm" ? 500 :
#     module.instance[count.index].instance_name == "analysis_dev_was_vm" ? 500 :
#     module.instance[count.index].instance_name == "map_dev_db_vm" ? 500 :
#     50)

#   volume_name = (module.instance[count.index].instance_name == "bastion_vm" ? "bastion_vol" : 
#     module.instance[count.index].instance_name == "analysis_test_web_vm" ? "analysis_test_web_vol" : 
#     module.instance[count.index].instance_name == "analysis_test_was_vm" ? "analysis_test_was_vol" : 
#     module.instance[count.index].instance_name == "analysis_test_db_vm" ? "analysis_test_db_vol" :
#     module.instance[count.index].instance_name == "analysis_dev_was_vm" ? "analysis_dev_was_vol" :
#     module.instance[count.index].instance_name == "map_dev_db_vm" ? "map_dev_db_vol" :
#     "default_vol")

#   # Zone A, B OS 설치 Zone과 같아야 함 그래서 instance 만들때 같이 만들어야 함!!! ㅠㅠ
#   availability_zone = count.index % 2 == 0 ? "kr-pub-a" : "kr-pub-b"
#   volume_type = "General HDD"
# }


# 공인 IP 할당 (internet gateway 가 연결된 VPC에만 할당 가능!! 현재는 VPC Default Network만 자동 가능!!)
# resource "nhncloud_networking_floatingip_v2" "web_fip" {
#   pool = "Public Network"
# }

# resource "nhncloud_networking_floatingip_v2" "bastion_fip" {
#   pool = "Public Network"
# }

# # 공인 IP 할당
# resource "nhncloud_networking_floatingip_associate_v2" "devops-fip_associate" {
#     floating_ip = nhncloud_networking_floatingip_v2.devops-fip.address
#     port_id = nhncloud_networking_port_v2.devops-nic.id
# }