output "impex-role" {
  description = "Impex Role Name"
  value = aws_iam_role.impex_ec2_role.name
}

output "impex_user" {
  description = "Impex User Name"
  value = aws_iam_user.impex_user.name
}

output "impex-profile" {
  description =  "Impex Instance Profile Name"
  value = aws_iam_instance_profile.impex-ec2-iam-profile.name
}

