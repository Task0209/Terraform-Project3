output "lamda_role" {
  value = aws_iam_role.lambda_role.name
}


output "submission-lambda-name" {
  description = "Function name for Lambda"
  value       = aws_lambda_function.impex-lambda.function_name
}

output "lambda-arn" {
  description = "ARN for Lambda"
  value       = aws_lambda_function.impex-lambda.invoke_arn
}
