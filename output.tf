
output "impex-booking-request-kmskey-id" {
  description = "The globally unique identifier for the Impex key"
  value       = module.kms-key.impex-booking-request-kmskey-id
}

output "sqs_dead_arn" {
  description = "ARN of SQS dead Queue"
  value = module.ftp-submitter-sqs-dead-letter.sqs_dead_arn
}


output "lambda-arn" {
  description = "ARN for Lambda"
  value       = module.submission-service-lambda.lambda-arn
}

output "ftp-lamda-arn" {
  description = "ARN for ftp Lambda"
  value       = module.ftp-submitter-lambda.ftp-lamda-arn
}

output s3bucket-arn {
  description = "ARN of s3 bucket"
  value = module.s3.s3bucket-arn
}

output "sqs_arn" {
  description = "ARN of SQS Queue"
  value = module.sqs.sqs_arn
}

output "secret-manager-name1-arn" {
  description = "ARN of Secret 1"
  value = module.secret-manager.secret-manager-name1-arn
}

output "secret-manager-name2-arn" {
  description = "ARN of Secret 2"
  value = module.secret-manager.secret-manager-name2-arn
}

output "cloudwatch_log_group_name1_arn" {
  description = "Log Group name for Booking Request"
  value       = module.cloudwatch-logs.cloudwatch_log_group_name1_arn
}

output "cloudwatch_log_group_name2_arn" {
  description = "Log Group name for Booking Request"
  value       = module.cloudwatch-logs.cloudwatch_log_group_name2_arn
}