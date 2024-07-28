resource "aws_ecs_task_definition" "api_task" {
  family = var.task_definition_family
  container_definitions = jsonencode(
    [
      {
        name                  = var.task_definition_family
        portMappings = [
          {
            containerPort = 80
            hostPort      = 0
            name          = "${var.task_definition_family}-80-tcp"
            protocol      = "tcp"
          },
        ]
        essential      = true
        image          = "public.ecr.aws/nginx/nginx"
        name           = "nginx"
      },
    ]
  )
  cpu                = "256"
  execution_role_arn = var.ecs_task_execution_role_arn
  memory             = "1024"
  network_mode       = "bridge"
  requires_compatibilities = [
    "EC2",
  ]
  skip_destroy = false
  tags = {}
  tags_all = {}

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}



