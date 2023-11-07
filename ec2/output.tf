output "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  value = aws_instance.Impex_server.tags
}

output "key-name" {
  description = "Name of Key Pair"
  value = aws_key_pair.impex-key-pair.key_name
}

output "keyfilename" {
  description = "Name of Key Pair file"
  value = local_file.impex-key.filename
}

output "instance_arn" {
  description = "ARN for the EC2 instance"
  value = aws_instance.Impex_server.arn
}