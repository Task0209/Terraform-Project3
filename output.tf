output "secret-manager-name" {
  description = "Name of Secret"
  value = aws_secretsmanager_secret.impex-booking-request-secret.name
}
