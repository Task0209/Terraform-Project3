
variable "submission-lambda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "run-time" {
  type        = string
  description = "Execution Runtime for Lambda"
  default = "python3.11"
}

variable "lamda-role" {
  type = string
  description =  "Lambda Role name"
  default = "impex-submission-lambda-role"
}

variable "lamda-handler" {
  type = string
  description =  "Lambda Handler"
  default = ""
}

variable "s3bucket-arn" {
  type = string
  description = "ARN of s3 bucket"
  default = ""
}

variable "sqs_arn" {
  description = "ARN of SQS Queue"
  type = string
  default = ""
}

variable "secret-manager-name1-arn" {
  description = "ARN of Secret 1"
  type = string
  default = ""
}

variable "secret-manager-name2-arn" {
  description = "ARN of Secret 2"
  type = string
  default = ""
}

variable "cloudwatch_log_group_name1_arn" {
  description = "Log Group name for Booking Request"
  type = string
  default = ""
}

variable "cloudwatch_log_group_name2_arn" {
  description = "Log Group name for Booking Request"
  type = string
  default = ""
}