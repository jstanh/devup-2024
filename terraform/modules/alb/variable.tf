variable "vpc_id" {
  type    = string
  description = "VPC Id"
}

variable "first_subnet_id" {
  type    = string
  description = "First Subnet Id"
}

variable "second_subnet_id" {
  type    = string
  description = "Api Domain Name"
}

variable "load_balancer_name" {
  type    = string
  description = "Load Balancer Name"
}

variable "target_group_name" {
  type    = string
  description = "Target Group Name"
}

variable "api_domain_name" {
  type    = string
  description = "Api Domain Name"
}

variable "load-balancer-security-group-id" {
  type    = string
  description = "Load balancer security group id"
}