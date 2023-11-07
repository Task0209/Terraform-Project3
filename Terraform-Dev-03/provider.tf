locals {
  config1 = yamldecode(file("conf.yaml"))
}

provider "aws" {
  region = local.config1.regions.region1
}
