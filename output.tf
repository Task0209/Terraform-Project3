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
  description = "Value of the Name tag for the EC2 instance"
  value = module.ec2.instance_arn
}

output "instance_id" {
  description = "ID for the EC2 instance"
  value = module.ec2.instance_id
}

output s3bucket-arn {
  description = "ARN of s3 buckets"
  value = module.s3.s3bucket-arn
}
