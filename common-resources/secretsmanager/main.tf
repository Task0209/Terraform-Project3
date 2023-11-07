resource "aws_secretsmanager_secret" "impex-booking-request-secret1" {
   name = "${var.secret-manager-name1}"
   recovery_window_in_days = var.rec_win_in_days // Overriding the default recovery window of 30 days
   kms_key_id = var.impex-booking-request-kmskey-id
}
 

resource "aws_secretsmanager_secret_version" "impex-booking-request-secret-version1" {
  secret_id = aws_secretsmanager_secret.impex-booking-request-secret1.id
  secret_string = "${jsonencode(var.impex-booking-request-cred-ftp)}"
}

resource "aws_secretsmanager_secret" "impex-booking-request-secret2" {
   name = "${var.secret-manager-name2}"
   recovery_window_in_days = var.rec_win_in_days // Overriding the default recovery window of 30 days
   kms_key_id = var.impex-booking-request-kmskey-id
}
 

resource "aws_secretsmanager_secret_version" "impex-booking-request-secret-version2" {
  secret_id = aws_secretsmanager_secret.impex-booking-request-secret2.id
  secret_string = "${jsonencode(var.impex-booking-request-cred-aws)}"
}

resource "aws_lambda_permission" "lambda_sqs_permission" {
  statement_id  = "AllowExecutionFromLambda"
  action        = "lambda:InvokeFunction"
  function_name = "${var.submission-lambda-name}"
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret_version.impex-booking-request-secret-version1.arn
}

resource "aws_lambda_permission" "lambda_sqs_permission_ftp" {
  statement_id  = "AllowExecutionFromLambda"
  action        = "lambda:InvokeFunction"
  function_name = "${var.ftp-lamda-name}"
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret_version.impex-booking-request-secret-version2.arn
}