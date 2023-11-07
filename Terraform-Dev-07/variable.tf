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

variable "impex-cred" {
  type = map(object({
# Is there a variable for strings in JSON format?
    ftp_server  = any
    aws = any
  }))
  default = {
    "server_cred1"={
      ftp_server = {
        "host" : "TwentyFour_Hours",
        "username" : "ftpbroadwayinfo",
        "password": "zMIMlpRWpRG$",
        "directory": "/DM/Watcher/",
        "pol_time" : 10
      }
       aws = {
        "region" : "us-east-1",
        "s3bucket" : "bookingresponsedummy",
        "secretmanagerkey": "bookingresponsedummy",
        "sqs_url": " ",
        "access_id" : "AKIAUJ3LZ2VZ5Z5VX2KQ",
        "access_secret": "X7c2W4i9J4l9z8N7y0Kb8fP5mzJ6T4I8"
      }
      }
  }
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