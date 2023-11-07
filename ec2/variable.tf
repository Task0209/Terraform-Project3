variable "key-name" {
  description = "Name of Key Pair"
  type        = string
}

variable "alg" {
    description = "Method of an algorithm"
    type = string
    default = "RSA"
}


variable "bits" {
    description = "RSA Bits"
    type = number
    default = 4096
}

variable "keyfilename" {
  description = "Name of Key Pair file"
  type        = string
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
}

variable "amitype" {
    description = "AMI Type"
    type = string
    default = "ami-053b0d53c279acc90"
}

variable "instancetype" {
    description = "EC2 instance Type"
    type = string
    default = "t3.micro"
}

variable "impex-profile" {
  type = string
  description =  "Impex Instance Profile Name"
}

 variable "sg_id" {
  description = "ID of the Security Group"
  type = string
}

variable "subnet1-id" {
  description = "ID for subnet1"
  type = string
}
