resource "aws_codebuild_project" "api_build" {
  name           = var.build_project_name
  build_timeout  = 60
  queued_timeout = 480

  service_role = var.codebuild_role_arn

  artifacts {
    encryption_disabled    = false
    name                   = var.build_project_name
    override_artifact_name = false
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "codebuild"
      status      = "ENABLED"
      stream_name = var.build_project_name
    }
    s3_logs {
      bucket_owner_access = null
      encryption_disabled = false
      location            = null
      status              = "DISABLED"
    }
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"


  }

  source {
    type                = "CODEPIPELINE"
    report_build_status = false
    insecure_ssl        = false
    git_clone_depth     = 0
  }

  tags = {}
}
