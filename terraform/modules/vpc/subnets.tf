resource "aws_subnet" "development01" {
  vpc_id                                         = aws_vpc.development.id  
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "${var.aws_region}a"
  cidr_block                                     = "10.0.1.0/24"
  customer_owned_ipv4_pool                       = ""
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_customer_owned_ip_on_launch                = false
  map_public_ip_on_launch                        = false
  outpost_arn                                    = ""
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Name = "${var.vpc_name}-01"
  }
  tags_all = {
    Name = "${var.vpc_name}-01"
  }
  
}

resource "aws_subnet" "development02" {
  vpc_id                                         = aws_vpc.development.id
  assign_ipv6_address_on_creation                = false
  availability_zone                              = "${var.aws_region}b"
  cidr_block                                     = "10.0.2.0/24"
  customer_owned_ipv4_pool                       = ""
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  map_customer_owned_ip_on_launch                = false
  map_public_ip_on_launch                        = false
  outpost_arn                                    = ""
  private_dns_hostname_type_on_launch            = "ip-name"
  tags = {
    Name = "${var.vpc_name}-02"
  }
  tags_all = {
    Name = "${var.vpc_name}-02"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.development01.id
  route_table_id = aws_route_table.main-table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.development02.id
  route_table_id = aws_route_table.main-table.id
}