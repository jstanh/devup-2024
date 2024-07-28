resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80

  default_action {
    type = "forward"
    forward {
      stickiness {
        duration = 3600
        enabled  = false
      }
      target_group {
        arn    = aws_lb_target_group.api_target_group.arn
        weight = 1
      }
    }
  }
}