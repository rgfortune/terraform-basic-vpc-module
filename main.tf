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

resource "aws_internet_gateway" "igw" {
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
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "Public Route Table" }
}

resource "aws_subnet" "publicSubnets" {
  count = var.public_subnet_count
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr, 3, count.index)
  tags              = { Name = "Public Subnet-0${count.index}" }
}

resource "aws_route_table_association" "publicSubnets" {
  count = var.public_subnet_count
  subnet_id      = aws_subnet.publicSubnets[count.index].id
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

resource "aws_subnet" "privateSubnets" {
  count = var.private_subnet_count
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr, 3, count.index + var.public_subnet_count)
  tags              = { Name = "Private Subnet-0${count.index}" }
}

resource "aws_route_table_association" "privateSubnets" {
  count = var.private_subnet_count
  subnet_id      = aws_subnet.privateSubnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

