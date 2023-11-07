resource "aws_cloudwatch_log_group" "Booking_Request_logs" {
  name = "Booking_Request"
  retention_in_days = 30
  #kms_key_id = aws_kms_key.impex_kms_key_aus.id
}

resource "aws_cloudwatch_log_stream" "Booking_Request_logs_stream" {
  name           = "Booking_Request_logs_stream"
  log_group_name = aws_cloudwatch_log_group.Booking_Request_logs.name
}

resource "aws_cloudwatch_log_resource_policy" "impex-booking-request" {
  policy_document = data.aws_iam_policy_document.impex-booking-request.json
  policy_name     = "impex-booking-request"
}