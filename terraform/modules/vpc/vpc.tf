resource "aws_vpc" "development" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  instance_tenancy                     = "default"
  ipv4_ipam_pool_id                    = null
  ipv4_netmask_length                  = null
  ipv6_cidr_block_network_border_group = ""
  
  tags = {
    "Name" = var.vpc_name
  }
  tags_all = {
    "Name" = var.vpc_name
  }
}