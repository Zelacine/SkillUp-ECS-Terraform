/*output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
*/

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}