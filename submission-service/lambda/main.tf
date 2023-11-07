

data "archive_file" "impex-python" {
  type        = "zip"
  source_file = "${path.module}/impex.py"
  output_path = "${path.module}/impex.zip"
}

resource "aws_lambda_function" "impex-lambda" {
  function_name = "${var.submission-lambda-name}"
  filename        = "${path.module}/impex.zip"
  role    = aws_iam_role.lambda_role.arn
  handler = "${var.lamda-handler}"
  runtime = "${var.run-time}"
  depends_on  = [aws_iam_role_policy_attachment.lamda-cloudwatch-logs-policy-docs, 
                 aws_iam_role_policy_attachment.lambda-secret-policy-docs,
                 aws_iam_role_policy_attachment.lambda-s3-bucket-policy-docs,
                 aws_iam_role_policy_attachment.lambda-sqs-queue-policy-docs]
}