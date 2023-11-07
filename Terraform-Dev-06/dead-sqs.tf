resource "aws_sqs_queue" "impex_deadletter_queue" {
  name                        = "impex_deadletter_queue"
  message_retention_seconds   = var.retention_period
  visibility_timeout_seconds  = var.visibility_timeout
}

resource "aws_sqs_queue_redrive_allow_policy" "impex_deadletter_queue" {
  queue_url = aws_sqs_queue.impex_deadletter_queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.impex_sqs_queue.arn]
  })
}