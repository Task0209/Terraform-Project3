variable "aws_region" {
  default = "us-east-1"
}

variable "impex_user_arn" {
  default ="arn:aws:iam::266842636661:user/ubuntu"
}

variable key_spec {
  default = "SYMMETRIC_DEFAULT"
}

variable usage {
  default = "ENCRYPT_DECRYPT"
}
variable enabled {
  default = true
}

variable rotation_enabled {
  default = true
}


variable "impex-gatepass" {
  default = {
    pass1 = "WZ8U3nuBIKl@6QP"
    pass2 = "P@8V8ELncWjSRxP"
    sensitive = true
  }

  type = map(string)
}

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

variable "receive_count" {
  description = "The number of times that a message can be retrieved before being moved to the dead-letter queue"
  type = number
  default = 3
}

variable "delay_sec" {
  description = "Any message that is sent to the queue remains invisible to consumers for the duration of this delay period"
  type = number
  default = 10
}

variable "max_msg_sz"{
  description = "The maximum size of the message that can be sent to the SQS queue. If a message exceeds this size, it will be rejected"
  type = number
  default = 2048
}

variable receive_wait_sec {
   description = "This argument is useful to provide a time period that a request could wait for a message to become available in the queue. If no messages are available within this time, the request will return an empty response"
   type = number
   default = 2
}