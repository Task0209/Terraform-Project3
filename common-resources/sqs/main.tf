
resource "aws_sqs_queue" "impex-booking-request-sqs" {
  name                       = "${var.sqs_name}"
  delay_seconds              = var.delay_sec
  visibility_timeout_seconds = var.visibility_timeout
  max_message_size           = var.max_msg_sz
  message_retention_seconds  = var.retention_period
  receive_wait_time_seconds  = var.receive_wait_sec

  redrive_policy             = jsonencode({
                                    "deadLetterTargetArn" = var.sqs_dead_arn,
                                    "maxReceiveCount" = var.receive_count
                                })
}

resource "aws_lambda_permission" "ftp_lambda_sqs_permission" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = "${var.ftp-lamda-name}"
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.impex-booking-request-sqs.arn
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = aws_sqs_queue.impex-booking-request-sqs.arn
  enabled          = true
  function_name    = "${var.ftp-lamda-name}"
  batch_size       = var.bat-size
}

resource "aws_lambda_permission" "submission_lambda_sqs_permission" {
  statement_id  = "AllowExecutionFromDeadSQS1"
  action        = "lambda:InvokeFunction"
  function_name = "${var.submission-lambda-name}"
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.impex-booking-request-sqs.arn
}

resource "aws_lambda_function_event_invoke_config" "event_invoke_config" {
  function_name = "${var.submission-lambda-name}"

  destination_config {

    on_success {
      destination = aws_sqs_queue.impex-booking-request-sqs.arn
    }
  }
}