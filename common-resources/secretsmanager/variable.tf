
variable "impex-booking-request-kmskey-id" {
  description = "KMS Key ID for Impex Client"
  type        = string
}

variable "secret-manager-name1" {
  description = "Name of the Secret Manager1"
  type = string
}

variable "secret-manager-name2" {
  description = "Name of the Secret Manager2"
  type = string
}


variable "rec_win_in_days" {
  description = "Recovery Windows in Days"
  type = number
}

variable "impex-booking-request-cred-ftp" {
  type = map(string)
# Is there a variable for strings in JSON format?
   sensitive = true
   default = {
    host = "TwentyFour_Hours"
    username = "ftpbroadwayinfo"
    password = "zMIMlpRWpRG$"
    directory = "/DM/Watcher/"
    pol_time = 10
}
}

variable "impex-booking-request-cred-aws" {
  type = map(string)
# Is there a variable for strings in JSON format?
   sensitive = true
   default = {
    region = "us-east-1"
    s3bucket = "bookingresponsedummy"
    secretmanagerkey = "bookingresponsedummy"
    sqs_url = ""
    access_id = "AKIAUJ3LZ2VZ5Z5VX2KQ"
    access_secret = "X7c2W4i9J4l9z8N7y0Kb8fP5mzJ6T4I8"
}
}

variable "submission-lambda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}

variable "ftp-lamda-name" {
  type = string
  description = "Name of the Lambda Function"
  default = ""
}