resource "aws_sqs_queue" "impex_sqs_queue" {
  name                       = "impex_sqs_queue"
  delay_seconds              = var.delay_sec
  visibility_timeout_seconds = var.visibility_timeout
  max_message_size           = var.max_msg_sz
  message_retention_seconds  = var.retention_period
  receive_wait_time_seconds  = var.receive_wait_sec
}

resource "aws_sqs_queue_redrive_policy" "impex_sqs_queue" {
  queue_url = aws_sqs_queue.impex_sqs_queue.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.impex_deadletter_queue.arn
    maxReceiveCount     = "${var.receive_count}"
  })
}