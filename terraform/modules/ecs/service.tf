resource "aws_ecs_service" "api_task" {
  name                    = var.ecs_service_name
  cluster                 = aws_ecs_cluster.exchangeCluster.id
  desired_count           = 8
  enable_ecs_managed_tags = true
  task_definition         = aws_ecs_task_definition.api_task.id
  wait_for_steady_state   = false
  load_balancer {
    container_name   = "nginx"
    container_port   = 80
    target_group_arn = var.target_group_arn
  }
  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }
  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }
}