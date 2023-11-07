variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "Impex-Aus-Instance"
}

variable "amitype" {
    default = "ami-0310483fb2b488153"
}

variable "instancetype" {
    default = "t3.micro"
}

variable "aws_region" {
  default = "ap-southeast-2"
}


variable "environment" {
  default = "staging"
}

variable "vpc_cidr" {
  default     = "10.10.0.0/16"
  description = "CIDR block of the vpc"
}

variable "subnet_impex_aus_cidr" {
  default     = "10.10.1.0/24"
  description = "CIDR block for Public Subnet"
}

variable "key_spec" {
  default = "SYMMETRIC_DEFAULT"
}

variable enabled {
  default = true
}

variable rotation_enabled {
  default = true
}