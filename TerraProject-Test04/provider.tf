# Declare Local Variable for Retrieve the value from Yaml Input File

locals {
  conf = yamldecode(file("conf1.yaml"))
}

provider "aws" {
  region  = local.conf.aws_region.default
}