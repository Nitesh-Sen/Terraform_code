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
resource "aws_subnet" "Private_subnets" {
  count             = 2
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  depends_on        = [aws_vpc.VPC]
  tags = {
    Name = "${var.NameTag}-Private-Subnet"
  }
}


##############################################################
#                       PUBLIC SUBNETS 
##############################################################
resource "aws_subnet" "Public_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.VPC]
  tags = {
    Name = "${var.NameTag}-Public-Subnet"
  }
}


##############################################################
#                       INTERNET GATEWAY 
##############################################################
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.VPC.id
  depends_on = [aws_vpc.VPC]
  tags = {
    Name = "${var.NameTag}-IGW"
  }
}


##############################################################
#                       ROUTE TABLES
##############################################################
#  ----------> PUBLIC ROUTE TABLES <-------------
resource "aws_route_table" "public" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.NameTag}-Public-Route-Table"
  }
}
resource "aws_route" "public_internet_gateway" {
  count                  = length(aws_route_table.public.*.id)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.Public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

#  ----------> PUBLIC ROUTE TABLES <-------------
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name = "${var.NameTag}-Private-Route-Table"
  }
}
resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.Private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
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
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  subnet_id              = aws_subnet.Public_subnets[0].id
  key_name               = "nsen"
  instance_type          = "t2.micro"
  user_data              = file("bash.sh")
  tags = {
    Name = "${var.NameTag}-EC2-Instance"
  }
}

