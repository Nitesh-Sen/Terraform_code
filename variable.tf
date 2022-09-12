###      Regions

variable "aws_region" {
  description = "AWS region"
  type        = map(any)
  default = {
    N_Virginia = "us-east-1"
    California = "us-west-1"
  }
}


###  CIDR Block

variable "CIDR" {
  type        = string
  default     = "10.0.0.0/16"
  description = "description"
}

###  CIDR Block Public

variable "public_cidr" {
  type        = list(any)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
  description = "description"
}


###  CIDR Block Private

variable "private_cidr" {
  type        = list(any)
  default     = ["10.0.32.0/19", "10.0.64.0/18"]
  description = "description"
}


###  Name

variable "name" {
  default     = "nitesh"
  type        = string
  description = "Name of the VPC"
}



########################### TAGS ###########################

###   Terraform 

variable "Terraform" {
  default     = ["Yes", "No"]
  type        = list(any)
  description = "Name of the VPC"
}


###   Project

variable "project" {
  type        = string
  default     = "production"
  description = "Name of project this VPC is meant to house"
}


####   Environment 

variable "environment" {
  type        = list(any)
  default     = ["production", "devlopment", "web"]
  description = "Name of environment this VPC is targeting"
}


###   Availability Zones

variable "availability_zones" {
  type = map(any)
  default = {
    a           = "us-east-1a"
    b           = "us-east-1b"
    description = "List of availability zones"
  }
}
variable "bucket_name" {
    default = "niteshsen437nitu"
}

variable "acl_value" {
    default = "private"
}
