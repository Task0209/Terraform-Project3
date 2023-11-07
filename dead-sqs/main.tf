resource "aws_sqs_queue" "impex-booking-request-sqs-dead-letter" {
  name                        = "${var.dead_sqs_name}"
  message_retention_seconds   = var.retention_period
  visibility_timeout_seconds  = var.visibility_timeout
}

resource "aws_lambda_permission" "ftp_lambda_sqs_permission" {
  statement_id  = "AllowExecutionFromDeadSQS"
  action        = "lambda:InvokeFunction"
  function_name = "${var.fun1-name}"
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.impex-booking-request-sqs-dead-letter.arn
}

resource "aws_lambda_function_event_invoke_config" "event_invoke_config" {
  function_name = "${var.fun1-name}"

  destination_config {

    on_failure {
      destination = aws_sqs_queue.impex-booking-request-sqs-dead-letter.arn
    }
  }
}

