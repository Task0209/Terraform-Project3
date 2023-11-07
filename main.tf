provider "aws" {
  region  = var.region
}

resource "aws_secretsmanager_secret" "impex-booking-request-secret" {
   name = "${var.secret-manager-name}"
   recovery_window_in_days = var.rec_win_in_days // Overriding the default recovery window of 30 days
  # kms_key_id = var.impex-booking-request-kmskey-id
}
 

resource "aws_secretsmanager_secret_version" "impex-booking-request-secret-version" {
  secret_id = aws_secretsmanager_secret.impex-booking-request-secret.id
  secret_string = "${jsonencode(var.impex-booking-request-cred)}"
}

