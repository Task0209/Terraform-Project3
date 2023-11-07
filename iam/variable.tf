variable "impex-profile" {
  type = string
  description =  "Impex Instance Profile Name"
}

variable "impex-role" {
  type = string
  description =  "Impex Role Name"
}

variable "instance_arn" {
  description = "Value of the Name tag for the EC2 instance"
  type = string
}

variable "s3bucket-arn" {
  description = "ARN of s3 buckets"
  type = string
}

variable "impex_user" {
  type = string
  description =  "Impex User Name"
}

variable "imp-acckey" {
  type = string
  description =  "Impex User Access key name"
  default = "impex-access-key"
}

variable "imp-seckey" {
  type = string
  description =  "Impex User Secret key name"
  default = "impex-secret-key"
}