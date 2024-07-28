resource "aws_lb_target_group" "api_target_group" {
  name                               = var.target_group_name
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = false
  load_balancing_algorithm_type      = "round_robin"
  load_balancing_anomaly_mitigation  = "off"
  load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
  protocol                           = "HTTP"
  protocol_version                   = "HTTP1"
  proxy_protocol_v2                  = false
  tags                               = {}
  tags_all                           = {}
  target_type                        = "instance"
  port                               = 80

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    timeout             = 5
    unhealthy_threshold = 2
  }

  stickiness {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }


  vpc_id = var.vpc_id
}