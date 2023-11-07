provider "aws" {
  region  = var.region
}


module "lambda1" {
  source          = "./lambda1/"
  lambda1-name = "${var.env}-${var.region}-${var.service}-lambda1-${var.ver}"
  s3bucket-arn = module.s3.s3bucket-arn
}

module "s3" {
  source = "./s3/"
  lambda1-name = "${var.env}-${var.region}-${var.service}-lambda1-${var.ver}"
  s3bucket = "${var.env}-${var.region}-${var.service}-s3-${var.ver}"
  OwnerShip-Permission = var.OwnerShip-Permission
  access_control_list = var.access_control_list
  lambda1-arn = module.lambda1.lambda1-arn
} 

