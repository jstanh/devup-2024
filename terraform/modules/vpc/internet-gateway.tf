resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.development.id

  tags = {
    Name = var.gateway_name
  }
  tags_all = {
    Name = var.gateway_name
  }
}