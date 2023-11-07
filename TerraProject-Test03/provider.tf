
locals {
  conf = yamldecode(file("conf.yaml"))
}

provider "aws" {
  region  = local.conf.vpc.aws_region
}