
variable "retention_period" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type = number
  default = 86400
}


variable "visibility_timeout" {
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  type = number
  default = 60
}

variable "dead_sqs_name" {
  description = "Name of SQS Queue"
  type = string
}

variable "fun1-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}