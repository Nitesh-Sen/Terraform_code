output "vpc-ID" {
  value       = aws_vpc.VPC.id
  description = "AWS vpc id"
}
output "EC2-Public-IP" {
  value       = aws_instance.Ec2Instance.public_ip
  description = "PublicIP of instance"
}

