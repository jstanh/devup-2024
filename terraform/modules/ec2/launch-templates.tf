resource "aws_launch_template" "exchangeLaunchTemplate" {
  name                    = "ECS-Cluster"
  description             = "ECS-Cluster"
  disable_api_termination = false
  ebs_optimized           = "false"
  image_id                = "ami-04fbff698680f6225"
  instance_type           = var.ECS_instance_size
  tags                    = {}
  user_data               = base64encode("#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;")

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      encrypted             = "false"
      volume_size           = 30
    }
  }

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    arn  = aws_iam_instance_profile.cluster_profile.arn
  }

  network_interfaces {
    associate_public_ip_address = "true"
  }
  
}

resource "aws_iam_instance_profile" "cluster_profile" {
  name = "cluster_profile"
  role = var.ecs_instance_role_name
}

resource "aws_autoscaling_group" "ecs_instances" {
  vpc_zone_identifier = [var.first_subnet_id, var.second_subnet_id]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.exchangeLaunchTemplate.id
  }
}