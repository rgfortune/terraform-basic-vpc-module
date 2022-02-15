locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.availability_zones_count)

  # Calculate subnet CIDR lists
  limit               = var.availability_zones_count * 2
  public_subnet_list  = [for subnet in range(var.availability_zones_count) : cidrsubnet(var.cidr, 3, subnet)]
  private_subnet_list = [for subnet in range(var.availability_zones_count, local.limit) : cidrsubnet(var.cidr, 3, subnet)]
}