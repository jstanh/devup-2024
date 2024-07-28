output "cluster_name" {
  description = "The ID of the cluster"
  value       = try(aws_ecs_cluster.exchangeCluster.name, null)
}

output "service_name" {
  description = "The ID of the service"
  value       = try(aws_ecs_service.api_task.name, null)
}