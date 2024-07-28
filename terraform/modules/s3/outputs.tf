output "client_bucket_domain_name" {
  description = "The Regional Domain Name of the Bucket"
  value       = try(aws_s3_bucket.bucket.bucket_regional_domain_name, null)
}

output "codebuild_bucket_id" {
  description = "The Id of the codebuild bucket"
  value       = try(aws_s3_bucket.codebuild_bucket.id, null)
}