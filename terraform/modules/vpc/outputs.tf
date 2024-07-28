output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.development.id, null)
}

output "first_subnet_id" {
  description = "The ID of the first Subnet"
  value       = try(aws_subnet.development01.id, null)
}

output "second_subnet_id" {
  description = "The ID of the second Subnet"
  value       = try(aws_subnet.development02.id, null)
}