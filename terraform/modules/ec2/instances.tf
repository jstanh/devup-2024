resource "aws_instance" "ECSInstance" {
  ami                                  = "ami-04fbff698680f6225"
  instance_type                        = var.ECS_instance_size
  associate_public_ip_address          = true
  disable_api_termination              = false
  ebs_optimized                        = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  ipv6_addresses                       = []
  monitoring                           = true
  secondary_private_ips                = []
  security_groups                      = []
  tags                                 = {}
  tags_all                             = {}
  user_data                            = "#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;"
  tenancy                              = "default"
  
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  enclave_options {
    enabled = false
  }

  launch_template {
    id = aws_launch_template.exchangeLaunchTemplate.id
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    tags                  = {}
    throughput            = 0
    volume_size           = 30
    volume_type           = "gp2"
  }

  cpu_options {
    core_count       = 1
    threads_per_core = 2

  }

  maintenance_options {
    auto_recovery = "default"
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  timeouts {}
}