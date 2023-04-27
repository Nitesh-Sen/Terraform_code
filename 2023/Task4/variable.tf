#########################################################
#                       Variables  
#########################################################
# ---------> NAME TAG <---------
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
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}
# Private CIDR
variable "public_subnets_cidr" {
  type    = list(any)
  default = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
}


# ----------> AVAILABILITY ZONES <----------
variable "availability_zones" {
  type    = list(any)
  default = ["us-west-1b", "us-west-1c"]
}
# -------->  AMAZON MACHINE IMAGES <----------
variable "ami" {
  type    = list(any)
  default = ["ami-0127b2e6f3b9b94d5", "ami-014d05e6b24240371", "ami-0e16c3bc75f23e32b", "ami-00522a6964c4a0c59"]
}
