variable api-name {
  type = string
  description = "Api name of the Lambda Function"
}

variable "submission-lambda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "lambda-arn" {
  description = "ARN for Lambda"
  type = string
  default = ""
}

variable "endpoint_path" {
  description = "Endpoint for api"
  type = string
  default = "impex-book-resource"
}
