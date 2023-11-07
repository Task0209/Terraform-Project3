variable region {
  type = string
  description = "Aws Region"
}

variable env {
  type = string
  description = "Environment"
}

variable service {
  type = string
  description = "Service"
}

variable ver {
  type = string
  description = "Version"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
  default = ""
}

variable "subnet1_name" {
  type = string
  description = "Name of the SUBNET 1"
  default = ""
}

variable "subnet2_name" {
  type = string
  description = "Name of the SUBNET 2"
  default = ""
}

variable "igw_name" {
  type = string
  description = "Name of the Internet Gateway"
  default = ""
}

variable "ngw_name" {
  type = string
  description = "Name of the NAT Gateway"
  default = ""
}

variable "eip_name" {
  type = string
  description = "Name of the Elastic IP"
  default = ""
}

variable "rt1_name" {
  type = string
  description = "Name of the Route table1"
  default = ""
}

variable "rt2_name" {
  type = string
  description = "Name of the Route table2"
  default = ""
}

 variable "des_cidr" {
    type = string
    default = " "
    description = "Destination address for Gateway"
 }

  variable "domains" {
     type = string
    description = "VPC for Elastic IP"
    default = " "
 }

variable "impex-role" {
  type = string
  description =  "Impex Role Name"
  default = " "
}

variable "impex_user" {
  type = string
  description =  "Impex User Name"
  default = ""
}

 variable "sg_name" {
  type = string
  description = "Name of the Security Group"
  default = ""
}

variable "s3bucket" {
    type = string
    description = "Name of s3 bucket"
    default = ""
}

variable "OwnerShip-Permission" {
    type = string
    description = "Permission behaviour for S3 Bucket Priority"
}

variable "access_control_list" {
    type = string
    description = "Types of access control list"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default = ""
}

variable "key-name" {
  description = "Name of Key Pair"
  type        = string
  default = ""
}

variable "keyfilename" {
  description = "Name of Key Pair file"
  type        = string
  default = ""
}

variable "subnet1-id" {
  description = "ID for subnet1"
  type = string
  default = ""
}

 variable "sg_id" {
  description = "ID of the Security Group"
  type = string
  default = ""
}


variable "impex-profile" {
  type = string
  description =  "Impex Instance Profile Name"
  default = ""
}
