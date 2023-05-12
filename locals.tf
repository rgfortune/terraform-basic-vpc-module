locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.availability_zones_count)

  # Calculate subnet CIDR lists

  # Generate lists of CIDRs to allocate to subnets

  # **************** EXAMPLE ****************
  # VPC CIDR  = 172.16.0.0/16
  # No of AZs = 2
  # Subnets:
  #    eks_eni_subnet_cidrs  = [172.16.0.0/22, 172.16.4.0/22]
  #    public_subnet_cidrs  = [172.16.8.0/22, 172.16.12.0/22, 172.16.16.0/22, 172.16.20.0/22, 172.16.24.0/22, 172.16.28.0/22, 172.16.32.0/22, 172.16.36.0/22]
  #    private_subnet_cidrs = [172.16.40.0/22, 172.16.44.0/22, 172.16.48.0/22, 172.16.52.0/22, 172.16.56.0/22, 172.16.60.0/22, ....., 172.16.80.0/22, .... etc]
  # **************** EXAMPLE ****************

  eks_eni_subnet_cidrs = [for subnet in range(var.availability_zones_count) : cidrsubnet(var.cidr, 6, subnet)]
  public_subnet_cidrs  = [for subnet in range(var.availability_zones_count, 12) : cidrsubnet(var.cidr, 6, subnet)]
  private_subnet_cidrs = [for subnet in range((var.availability_zones_count * 4), 30) : cidrsubnet(var.cidr, 6, subnet)]

  # Slice the CIDRs generated above into groups to allocate to application subnet tiers respectively
  eks_eni_subnet_cidrs_groups = [for num in range(1) : slice(local.eks_eni_subnet_cidrs, var.availability_zones_count * num, var.availability_zones_count * (num + 1))]
  public_subnet_cidrs_groups  = [for num in range(3) : slice(local.public_subnet_cidrs, var.availability_zones_count * num, var.availability_zones_count * (num + 1))]
  private_subnet_cidrs_groups = [for num in range(5) : slice(local.private_subnet_cidrs, var.availability_zones_count * num, var.availability_zones_count * (num + 1))]

  # **************** EXAMPLE ****************
  # eks_eni_subnet_cidrs_groups  = [[172.16.0.0/22, 172.16.4.0/22]]
  # public_subnet_cidrs_groups = [[172.16.8.0/22, 172.16.12.0/22], [172.16.16.0/22, 172.16.20.0/22], [172.16.24.0/22, 172.16.28.0/22], [172.16.32.0/22, 172.16.36.0/22]]
  # private_subnet_cidrs_groups = [[172.16.40.0/22, 172.16.44.0/22], [172.16.48.0/22, 172.16.52.0/22], [172.16.56.0/22, 172.16.60.0/22], ....., [172.16.80.0/22, 172.16.84.0/22], .... etc]
  # **************** EXAMPLE ****************

}