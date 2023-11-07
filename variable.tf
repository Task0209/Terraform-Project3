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


variable cloudwatch_log_group_name1 {
  type = string
  description = "Name of the Log Group"
  default = ""
}

variable cloudwatch_log_group_name2 {
  type = string
  description = "Name of the Log Group"
  default = ""
}

variable "impex_user_arn" {
  type = string
  description = "Impex User Arn"
}

variable key_spec {
  type = string
  description = "Key specification"
}

variable usage {
  type = string
  description = "Key Functions"
}

variable kms_key_name {
  type = string
  description = "KMS Key Name"
}

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
    default = ""
}


variable "sqs_name" {
  description = "Name of SQS Queue"
  type = string
  default = ""
}

variable dead_queue_name {
  type = string
  description = "Name of the dead letter queue"
  default = ""
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

variable "impex-booking-request-kmskey-id" {
  description = "KMS Key ID for Impex Client"
  type        = string
  default = ""
}

variable "secret-manager-name1" {
  description = "Name of the Secret Manager"
  type = string
  default = ""
}

variable "secret-manager-name2" {
  description = "Name of the Secret Manager"
  type = string
  default = ""
}

variable "rec_win_in_days" {
  description = "Recovery Windows in Days"
  type = number
}

variable "ftp-lamda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "submission-lambda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "lamda-handler" {
  type = string
  description =  "Lambda Handler"
  default = ""
}

variable "lambda-arn" {
  description = "ARN for Lambda"
  type = string
  default = ""
}

variable "ftp-lamda-arn" {
  description = "ARN for ftp Lambda"
  type = string
  default = ""
}
