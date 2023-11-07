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
    default = "t3.small"
}

variable "key-name" {
  description = "Name of Key Pair"
  type        = string
}

variable "vol-size" {
    description = "Volume size for root disk"
    type = number
    default = 30
}

variable "vol-type" {
    description = "Volume type for root disk"
    type = string
    default = "gp2"
}

variable "encryption" {
    description = "Enable the Encryption"
    type = bool
    default = true
}

variable "del-termination" {
    description = "Delete on Terminate"
    type = bool
    default = true
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

variable "subnet1-id" {
  description = "ID for subnet1"
  type = string
}


 variable "sg_id" {
  description = "ID of the Security Group"
  type = string
}

variable "impex-profile" {
  type = string
  description =  "Impex Instance Profile Name"
}