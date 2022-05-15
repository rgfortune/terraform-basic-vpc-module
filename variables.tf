#------------------------------------------------
# Variables
#------------------------------------------------

variable "vpc_name" {}
variable "cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "availability_zones_count" {
  type        = number
  description = "Number of availabilty zones to use"
  default     = 2
}

variable "public_subnets_count" {
  type        = number
  description = "Number of public subnets to create"
  default     = 2
}

variable "private_subnets_count" {
  type        = number
  description = "Number of private subnets to create"
  default     = 2
}

# Default to 1 in a public subnet.
# Setting to 2 or equal to the total number of availability zones in use will provide HA
variable "nat_gw_count" {
  type        = number
  description = "Number of NAT GWs in public subnets to create"
  default     = 1
}

variable "tags" {
  type        = map(any)
  description = "Common project/resource tags"
  default = {
    Project = "Test"
  }
}
