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
resource "aws_instance" "Ec2Instance" {
  ami           = "ami-0e16c3bc75f23e32b"
  key_name      = "nsen"
  instance_type = "t2.micro"
  tags = {
    Name = var.InstanceTag
  }
}


resource "aws_s3_bucket" "s3-bucket" {
  depends_on = [aws_instance.Ec2Instance]

  tags = {
    Owner = aws_instance.Ec2Instance.id
  }
}


# -----------> Outputs <-----------
output "Ec2-instance-ID" {
  value       = aws_instance.Ec2Instance.id
  description = "Aws Instance ID"
}

output "Ec2-Instance-Name" {
  value       = var.InstanceTag
  description = "aws Instance name"
}

output "S3-Bucket-Name" {
  value       = aws_s3_bucket.s3-bucket.bucket_domain_name
  description = "Bucket ARN"
}
