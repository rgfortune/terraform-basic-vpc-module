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

resource "aws_subnet" "publicSubnet00" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = cidrsubnet(var.cidr, 3, 0)
  tags              = { Name = "Public Subnet-00" }
}

resource "aws_subnet" "publicSubnet01" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = cidrsubnet(var.cidr, 3, 1)
  tags              = { Name = "Public Subnet-01" }
}

resource "aws_route_table_association" "publicSubnet00" {
  subnet_id      = aws_subnet.publicSubnet00.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "publicSubnet01" {
  subnet_id      = aws_subnet.publicSubnet01.id
  route_table_id = aws_route_table.public_route_table.id
}


#------------------------------------------- 
# Private Subnets
#------------------------------------------- 

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  #route {
  #  cidr_block = "0.0.0.0/0"
  #nat_gateway_id = "${aws_nat_gateway.gw1.id}"
  #}
  tags = { Name = "Private Route Table" }
}

resource "aws_subnet" "privateSubnet00" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = cidrsubnet(var.cidr, 3, 3)
  tags              = { Name = "Private Subnet A" }
}

resource "aws_subnet" "privateSubnet01" {
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = cidrsubnet(var.cidr, 3, 4)
  tags              = { Name = "Private Subnet B" }
}

resource "aws_route_table_association" "privateSubnet00" {
  subnet_id      = aws_subnet.privateSubnet00.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "privateSubnet01" {
  subnet_id      = aws_subnet.privateSubnet01.id
  route_table_id = aws_route_table.private_route_table.id
}
