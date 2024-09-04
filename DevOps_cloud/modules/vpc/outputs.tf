output "vpc_id" {
  value = nhncloud_networking_vpc_v2.vpc.id
}

output "vpc_rt_id" {
  value = nhncloud_networking_routingtable_v2.vpc_rt.id
}

# output "subnet_id" {
#   value = nhn_subnet.example.id
# }
