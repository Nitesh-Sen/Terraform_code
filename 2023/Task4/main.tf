##############################################################
#                       VPC 
##############################################################
resource "aws_vpc" "VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.NameTag}-VPC"
  }
}


##############################################################
#                       PRIVATE SUBNETS
##############################################################
resource "aws_subnet" "Private_subnet_1" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnets_cidr[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "${var.NameTag}-Private-Subnet_1"
  }
}

resource "aws_subnet" "Private_subnet_2" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnets_cidr[1]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "${var.NameTag}-Private-Subnet_2"
  }
}

resource "aws_subnet" "Private_subnet_3" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnets_cidr[2]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "${var.NameTag}-Private-Subnet_3"
  }
}

resource "aws_subnet" "Private_subnet_4" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnets_cidr[3]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "${var.NameTag}-Private-Subnet_4"
  }
}
##############################################################
#                       PUBLIC SUBNETS 
##############################################################
resource "aws_subnet" "Public_subnet_1" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_subnets_cidr[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.NameTag}-Public-Subnet_1"
  }
}
resource "aws_subnet" "Public_subnet_2" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.public_subnets_cidr[1]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.NameTag}-Public-Subnet_2"
  }
}

resource "aws_subnet" "Public_subnet_3" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.public_subnets_cidr[2]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.NameTag}-Public-Subnet_2"
  }
}

resource "aws_subnet" "Public_subnet_4" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.public_subnets_cidr[3]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.NameTag}-Public-Subnet_2"
  }
}

##############################################################
#                       INTERNET GATEWAY 
##############################################################
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.VPC.id
  depends_on = [aws_vpc.VPC]
  tags = {
    Name = "${var.NameTag}-Internet_GW"
  }
}


##############################################################
#                       ROUTE TABLES
##############################################################
#  ----------> PUBLIC ROUTE TABLES AVAILABILITY ZONE US-WEST-1B <-------------
resource "aws_route_table" "Public_rt_1" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name   = "${var.NameTag}-Public-Route-Table-1"
    region = var.availability_zones[0]
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.Public_rt_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "association-1" {
  subnet_id      = aws_subnet.Public_subnet_1.id
  route_table_id = aws_route_table.Public_rt_1.id
}
resource "aws_route_table_association" "association-2" {
  subnet_id      = aws_subnet.Public_subnet_2.id
  route_table_id = aws_route_table.Public_rt_1.id
}

#  ----------> PUBLIC ROUTE TABLES AVAILABILITY ZONE US-WEST-1C <-------------
resource "aws_route_table" "Public_rt_2" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name   = "${var.NameTag}-Public-Route-Table-2"
    region = var.availability_zones[1]
  }
}
resource "aws_route" "public_internet_gateway-2" {
  route_table_id         = aws_route_table.Public_rt_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "association-3" {
  subnet_id      = aws_subnet.Public_subnet_3.id
  route_table_id = aws_route_table.Public_rt_2.id
}
resource "aws_route_table_association" "association-4" {
  subnet_id      = aws_subnet.Public_subnet_4.id
  route_table_id = aws_route_table.Public_rt_2.id
}

#  ----------> PRIVATE ROUTE TABLES AVAILABILITY ZONE US-WEST-1B <-------------
resource "aws_route_table" "Private_rt_1" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name   = "${var.NameTag}-Private-Route-Table-1"
    region = var.availability_zones[0]
  }
}
resource "aws_route_table_association" "association-5" {
  subnet_id      = aws_subnet.Private_subnet_1.id
  route_table_id = aws_route_table.Private_rt_1.id
}
resource "aws_route_table_association" "association-6" {
  subnet_id      = aws_subnet.Private_subnet_2.id
  route_table_id = aws_route_table.Private_rt_1.id
}
#  ----------> PRIVATE ROUTE TABLES AVAILABILITY ZONE US-WEST-1C <-------------
resource "aws_route_table" "Private_rt_2" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name   = "${var.NameTag}-Private-Route-Table-2"
    region = var.availability_zones[1]
  }
}
resource "aws_route_table_association" "association-7" {
  subnet_id      = aws_subnet.Private_subnet_3.id
  route_table_id = aws_route_table.Private_rt_2.id
}
resource "aws_route_table_association" "association-8" {
  subnet_id      = aws_subnet.Private_subnet_4.id
  route_table_id = aws_route_table.Private_rt_2.id
}

##############################################################
#                       SECURITY GROUP
##############################################################
resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.VPC.id
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
    Name = "${var.NameTag}-SG"
  }
}


########################################################################
#                        EC2 Instance 
########################################################################
resource "aws_instance" "Ec2Instance" {
  ami                    = var.ami[1]
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id              = aws_subnet.Public_subnet_1.id
  key_name               = "nsen"
  instance_type          = "t2.micro"
  user_data              = file("bash.sh")
  tags = {
    Name = "${var.NameTag}-EC2-Instance"
  }
}