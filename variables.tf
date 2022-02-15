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

variable "tags" {
  type = map(any)
}
