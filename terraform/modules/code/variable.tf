variable "code_pipeline_name" {
  type    = string
  description = "Name of Pipeline"
}

variable "repository_name" {
  type    = string
  description = "Name of Repository"
}

variable "cluster_name" {
  type    = string
  description = "Name of Cluster"
}

variable "service_name" {
  type    = string
  description = "Name of Service"
}

variable "build_project_name" {
  type    = string
  description = "Name of Build Project"
}

variable "codebuild_role_arn" {
  type = string
  description = "Codebuild Role ARN"
}

variable "codepipeline_role_arn" {
  type = string
  description = "Codepipeline Role ARN"
}

variable "codebuild_bucket_id" {
  type = string
  description = "Codebuild bucket Id"
}