output "key-name" {
  description = "Name of Key Pair"
  value = aws_key_pair.impex-key-pair.key_name
}

output "keyfilename" {
  description = "Name of Key Pair file"
  value = local_file.impex-key.filename
}

output "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  value = aws_instance.Impex_server.tags
}

output "instance_arn" {
  description = "Value of the Name tag for the EC2 instance"
  value = aws_instance.Impex_server.arn
}

output "instance_id" {
  description = "ID for the EC2 instance"
  value = aws_instance.Impex_server.id
}