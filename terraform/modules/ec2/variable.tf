variable "aws_region" {
  type    = string
  description = "AWS Region Id"
}

variable "ECS_instance_size" {
  type    = string
  description = "Cluster Image Size"
}

variable "first_subnet_id" {
  type    = string
  description = "First Subnet Id"
}

variable "second_subnet_id" {
  type    = string
  description = "Second Subnet Id"
}

variable "sg_ecs_cluster_instance_id" {
  type    = string
  description = "ECS Cluster Instance Security Group Id"
}

variable "ecs_instance_role_name" {
  type    = string
  description = "ECS Cluster Instance Role Name"
}

variable "ecs_cluster_name" {
  type    = string
  description = "ECS Cluster Name"
}