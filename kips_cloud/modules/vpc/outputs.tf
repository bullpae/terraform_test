output "vpc_id" {
  value = nhncloud_networking_vpc_v2.vpc.id
}

output "vpc_rts" {
  value = nhncloud_networking_routingtable_v2.vpc_rt
}

# output "subnet_id" {
#   value = nhn_subnet.example.id
# }
