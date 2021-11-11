#------------------------------------------------
# VPC Variables
#------------------------------------------------

variable "env" {
  type        = string
  description = "e.g. dev"
}
variable "vpc_name" {
  type        = string
  description = "e.g. Dev VPC"
}
variable "cidr" {
  type        = string
  description = "e.g. 10.72.176.0/21"
}
variable "region" {
  type        = string
  description = "e.g. eu-west-2"
}

variable "project_name" {
  type        = string
  description = "e.g. Worpress Blog"
}

variable "owner" {
  type        = string
  description = "e.g. Joe Public"
}
