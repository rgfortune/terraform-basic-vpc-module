#------------------------------------------------
# Variables
#------------------------------------------------

variable "vpc_name" {}
variable "cidr" {}

variable "public_subnet_count" {
  type = number
  description = "Number of public subnets to create"
  default = 2
}

variable "private_subnet_count" {
  type = number
  description = "Number of private subnets to create"
  default = 2
}

variable "env" {}
variable "region" {
  default = "us-east-1"
}

variable "owner" {}
variable "project" {}
