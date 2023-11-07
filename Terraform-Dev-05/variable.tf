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