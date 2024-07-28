variable "vpc_name" {
  type    = string
  description = "VPC Name"
}

variable "route_table_name" {
  type    = string
  description = "Name of VPC main route table"
}

variable "aws_region" {
  type    = string
  description = "AWS Region"
}

variable "subnet_name" {
  type    = string
  description = "Subnet name prefix"
}

variable "gateway_name" {
  type    = string
  description = "Internet Gateway Name"
}

variable "nacl_name" {
  type    = string
  description = "Network Access Control List Name"
}