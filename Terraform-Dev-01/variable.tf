variable "impex_user_arn" {
  default ="arn:aws:iam::266842636661:user/ubuntu"
}

variable key_spec {
  default = "SYMMETRIC_DEFAULT"
}

variable enabled {
  default = true
}

variable rotation_enabled {
  default = true
}