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


variable fun1-name {
  type = string
  description = "Name of the Lambda Function1"
  default = ""
}

variable "lambda1-arn" {
  description = "ARN for Lambda"
  type = string
  default = ""
}


variable "sqs_name" {
  description = "Name of SQS Queue"
  type = string
  default = ""
}

variable "dead_sqs_name" {
  description = "Name of Dead SQS Queue"
  type = string
   default = ""
}
