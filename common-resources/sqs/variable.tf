variable "sqs_name" {
  description = "Name of SQS Queue"
  type = string
}

variable sqs_dead_arn {
  description = "ARN of SQS dead Queue"
  type = string
}

variable "retention_period" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type = number
}

variable "receive_count" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type = number
}

variable "visibility_timeout" {
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  type = number
}


variable "delay_sec" {
  description = "Any message that is sent to the queue remains invisible to consumers for the duration of this delay period"
  type = number
}

variable "max_msg_sz"{
  description = "The maximum size of the message that can be sent to the SQS queue. If a message exceeds this size, it will be rejected"
  type = number
}

variable receive_wait_sec {
   description = "This argument is useful to provide a time period that a request could wait for a message to become available in the queue. If no messages are available within this time, the request will return an empty response"
   type = number
}

variable "ftp-lamda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "bat-size" {
  type = number
  description = "Batch size"
  default = 10
}

variable "submission-lambda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}