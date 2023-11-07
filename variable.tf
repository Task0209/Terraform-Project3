variable "region" {
  type = string
  description = "Aws Region"
}

variable "secret-manager-name" {
  description = "Name of the Secret Manager"
  type = string
}

variable "rec_win_in_days" {
  description = "Recovery Windows in Days"
  type = number
}

variable "impex-booking-request-cred" {
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

