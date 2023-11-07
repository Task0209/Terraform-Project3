provider "aws" {
  region  = var.region
}


module "vpc" {
  source          = "./vpc/"
  vpc_name = "${var.env}-${var.region}-${var.service}-vpc-${var.ver}"
  subnet1_name = "${var.env}-${var.region}-${var.service}-subnet1-${var.ver}"
  subnet2_name = "${var.env}-${var.region}-${var.service}-subnet2-${var.ver}"
  igw_name = "${var.env}-${var.region}-${var.service}-igw-${var.ver}"
  ngw_name = "${var.env}-${var.region}-${var.service}-ngw-${var.ver}"
  eip_name = "${var.env}-${var.region}-${var.service}-eip-${var.ver}"
  rt1_name = "${var.env}-${var.region}-${var.service}-route1-${var.ver}"
  rt2_name = "${var.env}-${var.region}-${var.service}-route2-${var.ver}"
  sg_name = "${var.env}-${var.region}-${var.service}-sg-${var.ver}"
  des_cidr = var.des_cidr
  domains = var.domains
}

module "iam" {
 source          = "./iam/"
 impex-role ="${var.env}-${var.region}-${var.service}-impex-ec2-role-${var.ver}"
 impex_user ="${var.env}-${var.service}-user"
 impex-profile = "${var.env}-${var.region}-${var.service}-ec2-profile-${var.ver}"
 instance_arn = module.ec2.instance_arn
}

module "s3" {
  source = "./s3/"
  s3bucket = "${var.env}-${var.region}-${var.service}-s3-${var.ver}"
  OwnerShip-Permission = var.OwnerShip-Permission
  access_control_list = var.access_control_list
}

module "ec2" {
  source = "./ec2/"
  instance_name = "${var.env}-${var.region}-${var.service}-instance-${var.ver}"
  key-name = "${var.env}-${var.region}-${var.service}-key-${var.ver}"
  keyfilename = "${var.env}-${var.region}-${var.service}-keyfilename-${var.ver}"
  sg_id = module.vpc.sg_id
  subnet1-id = module.vpc.subnet1-id
  impex-profile = var.impex-profile
}

