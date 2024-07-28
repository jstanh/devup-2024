resource "aws_s3_bucket" "bucket" {
  bucket              = var.client_site_name
  bucket_prefix       = null
  force_destroy       = false
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}

resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode(
    {
      Id = "PolicyForCloudFrontPrivateContent"
      Statement = [
        {
          Action = "s3:GetObject"
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = var.client_cloudfront_arn
            }
          }
          Effect = "Allow"
          Principal = {
            Service = "cloudfront.amazonaws.com"
          }
          Resource = "arn:aws:s3:::${var.client_site_name}/*"
          Sid      = "AllowCloudFrontServicePrincipal"
        },
      ]
      Version = "2008-10-17"
    }
  )
}

resource "aws_s3_bucket" "codebuild_bucket" {
  bucket              = "com.stanhouse.codebuild"
  bucket_prefix       = null
  force_destroy       = false
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}
