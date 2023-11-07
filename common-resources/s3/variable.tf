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

variable "ftp-lamda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "ftp-lamda-arn" {
  description = "ARN for ftp Lambda"
  type = string
  default = ""
}

variable "submission-lambda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

