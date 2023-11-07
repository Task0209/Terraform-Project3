
 output "domains" {
    description = "VPC for Elastic IP"
    value = module.vpc.domains
 }

 output "sg_id" {
  description = "ID of the Security Group"
  value = module.vpc.sg_id
}

output "subnet1-id" {
  description = "ID for subnet1"
  value = module.vpc.subnet1-id
}

output "impex-profile" {
  description =  "Impex Instance Profile Name"
  value = module.iam.impex-profile
}

output "instance_arn" {
  description = "ARN for the EC2 instance"
  value = module.ec2.instance_arn
}