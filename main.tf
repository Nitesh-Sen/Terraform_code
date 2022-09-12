### Resource-1: Virtual_Private_Cloud

resource "aws_vpc" "MyVpc" {
  cidr_block           = var.CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name        = "${var.name}-${var.project}"
      Environment = var.environment[0]
      Terraform   = var.Terraform[0]
    },

  )
}


### Resource-2: Internet_gateway 

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    Terraform = var.Terraform[0]
  }
}


### Resource-3: Aws_Route_Table

resource "aws_route_table" "private" {
  count = length(var.private_cidr)

  vpc_id = aws_vpc.MyVpc.id

  tags = {
    Name        = "PrivateRouteTable",
    Project     = var.project,
    Environment = var.environment[0]
    Terraform   = var.Terraform[0]
  }
}


### Resource-4: Aws_Route




### Resource-5: Aws_Route_Table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.MyVpc.id
}


### Resource-6: Private_Subnets

resource "aws_subnet" "private1" {

  vpc_id            = aws_vpc.MyVpc.id
  cidr_block        = var.private_cidr[0]
  availability_zone = var.availability_zones.a

}
resource "aws_subnet" "private2" {

  vpc_id            = aws_vpc.MyVpc.id
  cidr_block        = var.private_cidr[1]
  availability_zone = var.availability_zones.b
}



### Resource-7: Public_Subnets
resource "aws_subnet" "public1" {

  vpc_id                  = aws_vpc.MyVpc.id
  cidr_block              = var.public_cidr[0]
  availability_zone       = var.availability_zones.a
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {

  vpc_id                  = aws_vpc.MyVpc.id
  cidr_block              = var.public_cidr[1]
  availability_zone       = var.availability_zones.b
  map_public_ip_on_launch = true
}
# Resource-6: S3 Bucket

resource "aws_s3_bucket" "a" {
    bucket = "${var.bucket_name}" 
    tags = {
    Name = trim("${var.name}-${var.environment[0]}","nitesh-")
  }
}
