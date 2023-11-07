
variable cloudwatch_log_group_name1 {
  type = string
  description = "Name of the Log stream"
}

variable cloudwatch_log_group_name2 {
  type = string
  description = "Name of the Log stream"
}

variable "retention_days" {
  type = number
  default = 30
}