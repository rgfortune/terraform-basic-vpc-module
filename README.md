### -------------------------------------------
### Basic VPC
###  - Public and Private Subnets
###  - Internet Gateway
###  - NAT Gateway
### -------------------------------------------

Description:

Creates a VPC with a public and private subnet in each availability zone.

Example Usage:

    module "vpc" {
      source = "github.com/rgfortune/terraform-basic-vpc-module"

      # VPC Variables
      vpc_name = "My VPC"
      cidr     = "10.193.17.0/24"

      # Specify the number of AZs you want
      availability_zones_count = 2

      # Common Tags
      tags = {
        Owner       = "Ricardo Fortune"
        Project     = "Basic Template"
        Environment = "DEV"
      }

    }