resource "aws_cloudwatch_log_group" "impex-booking-request-logs1" {
  name = "${var.cloudwatch_log_group_name1}"
  retention_in_days = var.retention_days
  #kms_key_id = aws_kms_key.impex_kms_key_aus.id
}

resource "aws_cloudwatch_log_group" "impex-booking-request-logs2" {
  name = "${var.cloudwatch_log_group_name2}"
  retention_in_days = var.retention_days
  #kms_key_id = aws_kms_key.impex_kms_key_aus.id
}

