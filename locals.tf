locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.availability_zones_count)

  # Calculate subnet CIDR lists
  public_subnet_list  = [for subnet in range(var.public_subnets_count) : cidrsubnet(var.cidr, 6, subnet)]
  private_subnet_list = [for subnet in range(var.public_subnets_count, var.public_subnets_count + var.private_subnets_count) : cidrsubnet(var.cidr, 6, subnet)]
}