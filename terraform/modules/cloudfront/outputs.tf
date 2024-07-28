output "cloudfront_client_arn" {
  description = "The ARN of the Client Cloudfront Distribution"
  value       = try(aws_cloudfront_distribution.distribution.arn, null)
}