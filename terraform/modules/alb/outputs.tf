output "target_group_arn" {
  description = "The ARN of the load balancer target group"
  value       = try(aws_lb_target_group.api_target_group.arn, null)
}