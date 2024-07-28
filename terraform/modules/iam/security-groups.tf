resource "aws_security_group" "ECS-Cluster-Instance" {
  name        = "ECS-Cluster-Instance"
  description = "Cluster Instance Security"
  vpc_id      = var.vpc_id
  tags        = {}
  tags_all    = {}

  ingress = []

  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = null
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
}

resource "aws_vpc_security_group_ingress_rule" "allow_Load-Balancer" {
  security_group_id            = aws_security_group.ECS-Cluster-Instance.id
  referenced_security_group_id = aws_security_group.Load-Balancer.id
  ip_protocol                  = "-1"
}

resource "aws_security_group" "Load-Balancer" {
  name        = "cluster-load-balancer"
  description = "load balancer"
  vpc_id      = var.vpc_id
  tags        = {}
  tags_all    = {}

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = null
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
  egress = []
}

resource "aws_vpc_security_group_egress_rule" "allow_ECS-Cluster" {
  security_group_id            = aws_security_group.Load-Balancer.id
  referenced_security_group_id = aws_security_group.ECS-Cluster-Instance.id
  ip_protocol = "-1"  
}