#------------------------------------------------
# Variables
#------------------------------------------------

variable "vpc_name" {}
variable "cidr" {}

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

variable "tags" {
  type = map(any)
}
