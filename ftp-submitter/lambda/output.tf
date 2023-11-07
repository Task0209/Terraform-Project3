output "lamda_role" {
  value = aws_iam_role.lambda_role.name
}


output "ftp-lamda-name" {
  description = "Function name for Lambda"
  value       = aws_lambda_function.impex-lambda.function_name
}

output "ftp-lamda-arn" {
  description = "ARN for Lambda"
  value       = aws_lambda_function.impex-lambda.arn
}
