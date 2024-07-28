resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.development.id
  egress = [
    {
      action          = "allow"
      cidr_block      = "0.0.0.0/0"
      from_port       = 0
      icmp_code       = 0
      icmp_type       = 0
      ipv6_cidr_block = null
      protocol        = "-1"
      rule_no         = 100
      to_port         = 0
    }
  ]
  ingress = [
    {
      action          = "allow"
      cidr_block      = "0.0.0.0/0"
      from_port       = 0
      icmp_code       = 0
      icmp_type       = 0
      ipv6_cidr_block = null
      protocol        = "-1"
      rule_no         = 100
      to_port         = 0
    }
  ]
  subnet_ids = [
    aws_subnet.development01.id,
    aws_subnet.development02.id
  ]
}