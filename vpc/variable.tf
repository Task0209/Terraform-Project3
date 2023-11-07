variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

  variable "domains" {
     type = string
    description = "VPC for Elastic IP"
    default = "vpc"
 }

variable "azs" {
  type = string
  description = "Availability Zone"
  default = "us-east-1c"
}

variable "subnet1_name" {
  type = string
  description = "Name of the SUBNET 1"
}

variable "igw_name" {
  type = string
  description = "Name of the Internet Gateway"
}


variable "rt1_name" {
  type = string
  description = "Name of the Route table1"
}


variable "vpc_cidr" {
  default     = "192.168.0.0/16"
  description = "CIDR block of the vpc"
}

variable "subnet1_impex_cidr" {
  default     = "192.168.0.0/24"
  description = "CIDR block for Subnet 1"
}

 variable "des_cidr" {
     type = string
    description = "Destination address for Gateway"
 }

 variable "sg_name" {
  type = string
  description = "Name of the Security Group"
}

variable "instance_id" {
  description = "ID for the EC2 instance"
  type = string
}