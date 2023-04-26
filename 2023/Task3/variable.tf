
# ----------> Variables  <----------
variable "NameTag" {
  type        = string
  default     = "john"
  description = "customer name"
}


# ----------> VPC CIDR <----------
variable "vpc_cidr" {
  default = "10.0.0.0/16" #CIDR declaration for VPC
}


# ----------> SUBNET CIDR <----------
# Public CIDR
variable "private_subnets_cidr" {
  type    = list(any)
  default = ["10.0.0.0/23", "10.0.2.0/23" ]
}
# Private CIDR
variable "public_subnets_cidr" {
  type    = list(any)
  default = ["10.0.8.0/21", "10.0.16.0/20" ]
}


# ----------> AVAILABILITY ZONES <----------
variable "availability_zones" {
  type    = list(any)
  default = [ "us-west-1b", "us-west-1c"]
}