#------------------------------------------- 
# VPC
#------------------------------------------- 

resource "aws_vpc" "vpc" {
  lifecycle { prevent_destroy = "false" }
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = merge(var.common_tags, {
    Name = var.vpc_name
  })
}

#------------------------------------------- 
# Internet Gateway
#------------------------------------------- 

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.common_tags, {
    Name = var.vpc_name
  })
}

#-------------------------------------------
# Nat Gateway
#-------------------------------------------

resource "aws_eip" "nat_gws" {
  count = var.nat_gw_count
  vpc   = true

  tags = merge(var.common_tags, {
    Name = var.vpc_name
  })

}

resource "aws_nat_gateway" "nat_gws" {
  count         = var.nat_gw_count
  allocation_id = aws_eip.nat_gws[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = merge(var.common_tags, {
    Name = var.vpc_name
  })
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

  tags = merge(var.common_tags, {
    Name = "${var.vpc_name} - Public Route Table"
  })
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_names) >= 1 ? var.availability_zones_count : 0
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.availability_zones[(count.index % var.availability_zones_count)]
  cidr_block        = local.public_subnet_cidrs[count.index]

  tags = merge(var.common_tags, {
    Name = "${var.vpc_name} - Public Subnet 0${count.index}"
  })

}

resource "aws_route_table_association" "public_subnets" {
  count          = length(var.public_subnet_names)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#------------------------------------------- 
# Private Subnets
#------------------------------------------- 

resource "aws_route_table" "private_route_tables" {
  lifecycle {
    ignore_changes = [route]
  }
  count  = length(var.private_subnet_names)
  vpc_id = aws_vpc.vpc.id

  dynamic route {
    for_each = var.nat_gw_count > 0 ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gws[count.index].id
    }
  }

  tags = merge(var.common_tags, {
    Name = "${var.vpc_name} - Private Route Table 0${count.index}"
  })
}

resource "aws_subnet" "private_subnets_00" {
  count = length(var.private_subnet_names) >= 1 ? var.availability_zones_count : 0
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.availability_zones[(count.index % var.availability_zones_count)]
  cidr_block        = local.private_subnet_cidrs_groups[0][count.index]

  tags = merge(var.common_tags, {
    Name = "${var.vpc_name} - ${var.private_subnet_names[0]} Private Subnet"
  })
}

resource "aws_subnet" "private_subnets_01" {
  count = length(var.private_subnet_names) >= 2 ? var.availability_zones_count : 0
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.availability_zones[(count.index % var.availability_zones_count)]
  cidr_block        = local.private_subnet_cidrs_groups[1][count.index]

  tags = merge(var.common_tags, {
    Name = "${var.vpc_name} - ${var.private_subnet_names[1]} Private Subnet"
  })
}

resource "aws_subnet" "private_subnets_02" {
  count = length(var.private_subnet_names) >= 3 ? var.availability_zones_count : 0
  lifecycle { prevent_destroy = "false" }
  vpc_id            = aws_vpc.vpc.id
  availability_zone = local.availability_zones[(count.index % var.availability_zones_count)]
  cidr_block        = local.private_subnet_cidrs_groups[2][count.index]

  tags = merge(var.common_tags, {
    Name = "${var.vpc_name} - ${var.private_subnet_names[2]} Private Subnet"
  })
}

resource "aws_route_table_association" "private_subnets_00" {
  count          = length(var.private_subnet_names) >= 1 ? var.availability_zones_count : 0
  subnet_id      = aws_subnet.private_subnets_00[count.index].id
  route_table_id = aws_route_table.private_route_tables[0].id
}

resource "aws_route_table_association" "private_subnets_01" {
  count          = length(var.private_subnet_names) >= 2 ? var.availability_zones_count : 0
  subnet_id      = aws_subnet.private_subnets_01[count.index].id
  route_table_id = aws_route_table.private_route_tables[1].id
}

resource "aws_route_table_association" "private_subnets_02" {
  count          = length(var.private_subnet_names) >= 3 ? var.availability_zones_count : 0
  subnet_id      = aws_subnet.private_subnets_02[count.index].id
  route_table_id = aws_route_table.private_route_tables[2].id
}