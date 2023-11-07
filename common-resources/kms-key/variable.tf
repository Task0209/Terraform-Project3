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
variable enabled {
  type = string
  description = "Enable the Key"
  default = true
}

variable rotation_enabled {
  type = string
  description = "Rotation enabled for renew the Key"
  default = true
}

variable kms_key_name {
  type = string
  description = "KMS Key Name"
}

variable del_win_in_days {
  type = number
  description = "Number of deletion in day "
  default = 7
}