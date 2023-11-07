
variable "fun1-name" {
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
  default = "impex-lambda-role"
}

variable "lamda-handler" {
  type = string
  description =  "Lambda Handler"
  default = "impex.lambda_handler"
}


variable "lambda1-arn" {
  description = "ARN for Lambda"
  type = string
  default = ""
}

