variable "OwnerShip-Permission" {
    type = string
    description = "Permission behaviour for S3 Bucket Priority"
}

variable "access_control_list" {
    type = string
    description = "Types of access control list"
}

variable "s3bucket" {
    type = string
    description = "Name of s3 bucket"
}

variable "lambda1-name" {
  type = string
  description = "Name of the Lambda Function1"
  default = ""
}


variable "lambda1-arn" {
  description = "ARN for Lambda1"
  default = ""
  type = string
}
