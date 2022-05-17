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

variable "public_subnet_names" {
  type        = list(any)
  description = "List of private subnets"
  default     = ["public"]
}

variable "private_subnet_names" {
  type        = list(any)
  description = "List of private subnets"
  default     = ["private"]
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
