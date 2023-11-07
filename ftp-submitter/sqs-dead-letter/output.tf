output "sqs_dead_arn" {
  description = "ARN of SQS dead Queue"
  value = aws_sqs_queue.impex-booking-request-sqs-dead-letter.arn
}