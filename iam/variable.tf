variable "impex-role" {
  type = string
  description =  "Impex Role Name"
}

variable "impex_user" {
  type = string
  description =  "Impex User Name"
}

variable "s3bucket-arn" {
  type = string
  description = "ARN of s3 bucket"
  default = ""
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

variable "impex-profile" {
  type = string
  description =  "Impex Instance Profile Name"
}

variable "instance_arn" {
  description = "ARN for the EC2 instance"
  type = string
}