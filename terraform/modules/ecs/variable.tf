variable "ecs_instance_role_name" {
  type    = string
  description = "ECS Cluster Instance Role Name"
}

variable "ecr_repository_name" {
  type    = string
  description = "ECR Repository Name"
}

variable "target_group_arn" {
  type    = string
  description = "Target Group ARN"
}

variable "ecs_service_name" {
  type    = string
  description = "ECS Service Name"
}

variable "task_definition_family" {
  type    = string
  description = "Api Task Definition Family"
}

variable "ecs_task_execution_role_arn" {
  type    = string
  description = "ECS Task Execution Role ARN"
}

variable "cluster_name" {
  type = string
  description = "Name of Cluster"
}