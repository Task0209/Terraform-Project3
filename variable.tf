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


variable lambda1-name {
  type = string
  description = "Name of the Lambda Function1"
  default = ""
}


variable api-name {
  type = string
  description = "Api name of the Lambda Function"
  default = ""
}

variable "lambda1-arn" {
  description = "ARN for Lambda"
  type = string
  default = ""
}

variable "OwnerShip-Permission" {
    type = string
    description = "Permission behaviour for S3 Bucket Priority"
    default = ""
}

variable "access_control_list" {
    type = string
    description = "Types of access control list"
    default = ""
}

variable "s3bucket" {
    type = string
    description = "Name of s3 bucket"
    default = ""
}


