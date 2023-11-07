provider "aws" {
  region  = var.region
}


module "vpc" {
  source          = "./vpc/"
  vpc_name = "${var.env}-${var.region}-${var.service}-vpc-${var.ver}"
  subnet1_name = "${var.env}-${var.region}-${var.service}-subnet1-${var.ver}"
  igw_name = "${var.env}-${var.region}-${var.service}-igw-${var.ver}"
  rt1_name = "${var.env}-${var.region}-${var.service}-route1-${var.ver}"
  sg_name = "${var.env}-${var.region}-${var.service}-sg-${var.ver}"
  des_cidr = var.des_cidr
  instance_id = module.ec2.instance_id
}

module "iam" {
 source          = "./iam/"
 impex-profile = "${var.env}-${var.region}-${var.service}-impex-ec2-profile-${var.ver}"
 impex-role ="${var.env}-${var.region}-${var.service}-impex-ec2-role-${var.ver}"
 instance_arn = module.ec2.instance_arn
 s3bucket-arn = module.s3.s3bucket-arn
 impex_user ="${var.env}-${var.service}-${var.service}-impex-user-${var.ver}"
}


module "ec2" {
  source = "./ec2/"
  instance_name = "${var.env}-${var.region}-${var.service}-instance-${var.ver}"
  key-name = "${var.env}-${var.region}-${var.service}-impexkey-${var.ver}"
  keyfilename = "${var.env}-${var.region}-${var.service}-impexkeyfile-${var.ver}"
  sg_id = module.vpc.sg_id
  subnet1-id = module.vpc.subnet1-id
  impex-profile = module.iam.impex-profile
}

module "s3" {
  source = "./s3/"
  s3bucket = "${var.env}-${var.region}-${var.service}-s3-${var.ver}"
  OwnerShip-Permission = var.OwnerShip-Permission
  access_control_list = var.access_control_list
}

