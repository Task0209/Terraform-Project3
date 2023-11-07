output "sqs_dead_arn" {
  description = "ARN of SQS dead Queue"
  value = aws_sqs_queue.impex-booking-request-sqs-dead-letter.arn
}

output "dead_sqs_name" {
  description = "Name of SQS Queue"
  value = aws_sqs_queue.impex-booking-request-sqs-dead-letter.name
}