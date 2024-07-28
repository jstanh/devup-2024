resource "aws_route_table" "main-table" {
  vpc_id = aws_vpc.development.id
  

  route = [
    {
      carrier_gateway_id         = ""
      cidr_block                 = "0.0.0.0/0"
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = aws_internet_gateway.gw.id
      instance_id                = ""
      ipv6_cidr_block            = null
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
      core_network_arn           = ""
    }
  ]

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.development.id
  route_table_id = aws_route_table.main-table.id
}