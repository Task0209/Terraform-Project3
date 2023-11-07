output "impex-profile" {
  description =  "Impex Instance Profile Name"
  value = aws_iam_instance_profile.impex-ec2-profile.name
}

output "impex_user" {
  description = "Impex User Name"
  value = aws_iam_user.impex_user.name
}


