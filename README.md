### Basic VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
***

#### Description:

Creates a VPC with public and private subnets in each availability zone.

#### Example Usage:

    module "vpc" {
      source = "github.com/rgfortune/terraform-basic-vpc-module"

      # VPC Variables
      vpc_name = "My VPC"
      cidr     = "10.193.17.0/24"

      # Specify the number of AZs you want
      availability_zones_count = 2

      # Specify the number and type of subnets you want
      public_subnets_count = 2
      private_subnets_count = 4

      # Specify the number NAT GWs you want
      # Default to 1 in a public subnet.
      # Setting to 2 or equal to the total number of availability zones in use will provide HA
      nat_gw_count = 1

      # Common Tags
      tags = {
        Owner       = "Ricardo Fortune"
        Project     = "Basic Template"
        Environment = "DEV"
      }

    }