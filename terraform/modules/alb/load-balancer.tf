resource "aws_lb" "alb" {
  enable_deletion_protection = false
  name                       = var.load_balancer_name
  preserve_host_header       = true
  security_groups = [
    var.load-balancer-security-group-id
  ]
  subnets = [
    var.first_subnet_id,
    var.second_subnet_id
  ]
  tags     = {}
  tags_all = {}
}