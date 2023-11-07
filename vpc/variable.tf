variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

variable "subnet1_name" {
  type = string
  description = "Name of the SUBNET 1"
}

variable "subnet2_name" {
  type = string
  description = "Name of the SUBNET 2"
}

variable "igw_name" {
  type = string
  description = "Name of the Internet Gateway"
}

variable "ngw_name" {
  type = string
  description = "Name of the NAT Gateway"
}

variable "eip_name" {
  type = string
  description = "Name of the Elastic IP"
}

variable "rt1_name" {
  type = string
  description = "Name of the Route table1"
}

variable "rt2_name" {
  type = string
  description = "Name of the Route table2"
}

variable "vpc_cidr" {
  default     = "10.10.0.0/16"
  description = "CIDR block of the vpc"
}

variable "subnet1_impex_cidr" {
  default     = "10.10.1.0/24"
  description = "CIDR block for Subnet 1"
}

variable "subnet2_impex_cidr" {
  default     = "10.10.2.0/24"
  description = "CIDR block for Subnet 2"
}

 variable "des_cidr" {
     type = string
    description = "Destination address for Gateway"
 }

  variable "domains" {
     type = string
    description = "VPC for Elastic IP"
 }

 variable "sg_name" {
  type = string
  description = "Name of the Security Group"
}