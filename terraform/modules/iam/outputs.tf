output "sg_ecs_cluster_instance_id" {
  description = "ECS-Cluster-Instance Security Group Id"
  value       = try(aws_security_group.ECS-Cluster-Instance.id, null)
}

output "sg_load_balancer_id" {
  description = "cluster-load-balancer Security Group Id"
  value       = try(aws_security_group.Load-Balancer.id, null)
}

output "role_ecs_instance_name" {
  description = "ecsInstance Role Name"
  value       = try(aws_iam_role.ecsInstanceRole.name, null)
}

output "role_ecs_task_execution_arn" {
  description = "ecsInstance Role Name"
  value       = try(aws_iam_role.ecsTaskExecutionRole.arn, null)
}

output "role_codebuild_arn" {
  description = "codebuild Role ARN"
  value       = try(aws_iam_role.codebuild_role.arn, null)
}

output "role_codepipeline_arn" {
  description = "codepipeline Role ARN"
  value       = try(aws_iam_role.codepipeline_role.arn, null)
}