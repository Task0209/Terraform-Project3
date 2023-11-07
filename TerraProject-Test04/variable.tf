variable "environment" {
  default = "dev"
}

variable "vpc_cidr" {
  default     = "192.168.0.0/16"
  description = "CIDR block of the vpc"
}

variable "subnet_impex_aus_cidr" {
  default     = "192.168.1.0/24"
  description = "CIDR block for Public Subnet"
}

variable "az" {
  default = "ap-southeast-2b"
}

variable "aws_region" {
  default = "ap-southeast-2"
}