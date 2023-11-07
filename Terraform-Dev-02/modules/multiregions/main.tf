module "ap-southeast-2" {
  source = "./modules/multi-region"
  name   = "Impex-Aus"
  providers = {
    aws = "aws"
  }
}
module "us-east-1" {
  source = "./modules/multi-region"
  name   = "Impex-US"
  providers = {
    aws = "aws.US"
  }
}