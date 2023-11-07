output "lamda_role" {
  value = aws_iam_role.lambda_role.name
}


output "lambda1-name" {
  description = "Function name for Lambda"
  value       = aws_lambda_function.impex-lambda1.function_name
}

output "lambda1-arn" {
  description = "ARN for Lambda"
  value       = aws_lambda_function.impex-lambda1.arn
}
