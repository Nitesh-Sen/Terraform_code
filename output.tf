output "id" {
  value       = aws_vpc.MyVpc.id
  description = "VPC ID"
}
output "cidr_block" {
  value       = var.CIDR
  description = "The CIDR block associated with the VPC"
}
output "public_subnet_ids" {
  value       = aws_subnet.public1.*.id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = aws_subnet.private1.*.id
  description = "List of private subnet IDs"
}
