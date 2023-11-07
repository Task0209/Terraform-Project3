output "secret-manager-name1" {
  description = "Name of Secret"
  value = aws_secretsmanager_secret.impex-booking-request-secret1.name
}

output "secret-manager-name2" {
  description = "Name of Secret"
  value = aws_secretsmanager_secret.impex-booking-request-secret2.name
}

output "secret-manager-name1-arn" {
  description = "ARN of Secret 1"
  value = aws_secretsmanager_secret.impex-booking-request-secret1.arn
}

output "secret-manager-name2-arn" {
  description = "ARN of Secret 2"
  value = aws_secretsmanager_secret.impex-booking-request-secret2.arn
}