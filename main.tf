provider "aws" {
  region  = var.region
}


module "lambda1" {
  source          = "./lambda1/"
  fun1-name = "${var.env}-${var.region}-${var.service}-lambda1-${var.ver}"
}


module "sqs" {
  source = "./sqs"
  fun1-name = "${var.env}-${var.region}-${var.service}-lambda1-${var.ver}"
  sqs_name = "${var.env}-${var.region}-${var.service}-sqs-${var.ver}"
}

module "dead-sqs" {
  source = "./dead-sqs"
  fun1-name = "${var.env}-${var.region}-${var.service}-lambda1-${var.ver}"
  dead_sqs_name = "${var.env}-${var.region}-${var.service}-dead-sqs-${var.ver}"
}
