output s3bucket-arn {
  description = "ARN of s3 bucket"
  value = module.s3.s3bucket-arn
}

output "lambda1-arn" {
  description = "ARN for Lambda"
  value       = module.lambda1.lambda1-arn
}


