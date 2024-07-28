resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name              = var.client_bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_access_policy.id
    origin_id                = var.client_bucket_domain_name
    connection_attempts      = 3
    connection_timeout       = 10
  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = var.client_site_name
  default_root_object = "index.html"

  aliases = []

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.client_bucket_domain_name
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    default_ttl            = 0
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    max_ttl                = 0
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {}

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }
  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }
}

resource "aws_cloudfront_origin_access_control" "origin_access_policy" {
  name                              = "${var.client_site_name}-ap"
  description                       = ""
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}