# -----------> Terraform Version and Provider <-----------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16"
    }
  }
  required_version = ">= 1.4.0"
}


# -----------> Provider <-----------
provider "aws" {
  region = "us-west-1"
}


# -----------> Variables <-----------
variable "InstanceTag" {
  type    = string
  default = "Made By Terraform"
}



# -----------> Resources <-----------
resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http"
  description = "Allow http inbound traffic"



  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "http"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http_ssh"
  }
}

resource "aws_instance" "Ec2Instance" {
  ami                    = "ami-0e16c3bc75f23e32b"
  key_name               = "nsen"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  depends_on             = [aws_security_group.allow_http_ssh]
  user_data              = file("Bash.sh")
  tags = {
    Name = var.InstanceTag
  }
}


# -----------> Outputs <-----------
output "Ec2-instance-ID" {
  value       = aws_instance.Ec2Instance.id
  description = "Aws Instance ID"
  depends_on  = [aws_instance.Ec2Instance]
}

output "Ec2-Instance-Name" {
  value       = var.InstanceTag
  description = "aws Instance name"
  depends_on  = [aws_instance.Ec2Instance]
}  
output EC2-Public-IP {
  value       = aws_instance.Ec2Instance.public_ip
  description = "PublicIP"
  depends_on  = [aws_instance.Ec2Instance]
}
                         
