locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.availability_zones_count)

  # Calculate subnet CIDR lists
  public_subnet_cidrs = [for subnet in range(length(var.public_subnet_names)) : cidrsubnet(var.cidr, 6, subnet)]

  # Even split across at least two or more used availability zones. Will always have at least 4 private subnets (See Reference HA Architecture)
  #private_app_subnet_cidrs = [for subnet in range(var.public_subnets_count, var.public_subnets_count + var.private_subnets_count/2) : cidrsubnet(var.cidr, 6, subnet)]
  #private_data_subnet_cidrs = [for subnet in range(var.private_subnets_count, var.public_subnets_count + var.private_subnets_count) : cidrsubnet(var.cidr, 6, subnet)]

  # Generate a list of CIDRs to allocate to private subnets
  private_subnet_cidrs = [for subnet in range(length(var.public_subnet_names), 25) : cidrsubnet(var.cidr, 6, subnet)]

  # Slice the private_subnet_cidrs into groups to allocate to subnet application tiers (web, db, cache,...etc)
  private_subnet_cidrs_groups = [for num in range(5) : slice(local.private_subnet_cidrs, length(var.private_subnet_names) * num, length(var.private_subnet_names) * (num + 1))]

}