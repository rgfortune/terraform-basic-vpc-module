#------------------------------------------- 
# VPC
#------------------------------------------- 

resource "aws_vpc" "vpc" {
  lifecycle { prevent_destroy = "false" }
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Project     = var.project
    Owner       = var.owner
    Environment = var.env
  }
}

#------------------------------------------- 
# Internet Gateway
#------------------------------------------- 

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

#------------------------------------------- 
# Public Subnets
#------------------------------------------- 

resource "aws_route_table" "public_route_table" {
  lifecycle {
    ignore_changes = [route]
  }
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "Public Route Table" }
}

resource "aws_subnet" "publicAzA" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${var.region}a"
  cidr_block        = cidrsubnet(var.cidr, 3, 0)
  tags              = { Name = "Public Subnet A" }
}

resource "aws_subnet" "publicAzB" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${var.region}b"
  cidr_block        = cidrsubnet(var.cidr, 3, 1)
  tags              = { Name = "Public Subnet B" }
}

resource "aws_route_table_association" "publicAzA" {
  subnet_id      = aws_subnet.publicAzA.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "publicAzB" {
  subnet_id      = aws_subnet.publicAzB.id
  route_table_id = aws_route_table.public_route_table.id
}


#------------------------------------------- 
# Private Subnets
#------------------------------------------- 

resource "aws_subnet" "privateAzA" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${var.region}a"
  cidr_block        = cidrsubnet(var.cidr, 3, 3)
  tags              = { Name = "Private Subnet A" }
}

resource "aws_subnet" "privateAzB" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${var.region}b"
  cidr_block        = cidrsubnet(var.cidr, 3, 4)
  tags              = { Name = "Private Subnet B" }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  #route {
  #  cidr_block = "0.0.0.0/0"
  #nat_gateway_id = "${aws_nat_gateway.gw1.id}"
  #}
  tags = { Name = "Private Route Table" }
}

resource "aws_route_table_association" "privateAzA" {
  subnet_id      = aws_subnet.privateAzA.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "privateAzB" {
  subnet_id      = aws_subnet.privateAzB.id
  route_table_id = aws_route_table.private_route_table.id
}
