##########################################################################
# -----------> Outputs <-----------
##########################################################################
output "vpc-ID" {
  value       = aws_vpc.VPC.id
  description = "AWS vpc id"
  depends_on  = [aws_instance.Ec2Instance]
} 
output EC2-Public-IP {
  value       = aws_instance.Ec2Instance.public_ip
  description = "PublicIP of instance"
  depends_on  = [aws_instance.Ec2Instance]
}
