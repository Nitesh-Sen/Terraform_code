# Terraform

> Launch EC2 
>
> - Give tag by Variable 
>
> Create S3 Bucket
> 
> - Give tag:- Owner = "INSTANCE_ID"
>
> Output
>
> - Instance ID, Name
> 
> - S3 Bucket Name
<br />

- Create a file named by **main.tf** and add this below content in that file. Then you will follow other command run steps from [This File](https://github.com/Nitesh-Sen/Terraform_code/blob/aec7f333a1021ba69a71e2c07e0991ad42022af2/2023/Task2/README.md).

```
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
```

