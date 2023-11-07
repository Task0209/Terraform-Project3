output "sqs_name" {
  description = "Name of SQS Queue"
  value = aws_sqs_queue.impex-booking-request-sqs.name
}

output "sqs_arn" {
  description = "ARN of SQS Queue"
  value = aws_sqs_queue.impex-booking-request-sqs.arn
}


