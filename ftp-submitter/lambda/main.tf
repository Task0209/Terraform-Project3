

data "archive_file" "impex-python" {
  type        = "zip"
  source_file = "${path.module}/impex.py"
  output_path = "${path.module}/impex.zip"
}

resource "aws_lambda_function" "impex-lambda" {
  function_name = "${var.ftp-lamda-name}"
  filename        = "${path.module}/impex.zip"
  role    = aws_iam_role.lambda_role.arn
  handler = "${var.lamda-handler}"
  runtime = "${var.run-time}"
  depends_on  = [aws_iam_role_policy_attachment.ftp-lamda-policy-cloudwatch-logs-docs, 
                 aws_iam_role_policy_attachment.ftp-lambda-secret-policy-docs,
                 aws_iam_role_policy_attachment.ftp-lambda-policy-s3-docs,
                 aws_iam_role_policy_attachment.ftp-lambda-sqs-policy-docs,
                 aws_iam_role_policy_attachment.ftp-lambda-dead-sqs-policy-docs]
}