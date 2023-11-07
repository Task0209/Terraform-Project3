resource "aws_iam_role" "lambda_role" {
name   = "${var.lamda-role}"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "ftp-lamda-policy-cloudwatch-logs" {
 
 name         = "ftp-lamda-policy-cloudwatch-logs"
 path         = "/"
 description  = "Policy for Lambda to capture the logs in Cloud watch"
 policy = jsonencode(
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": [var.cloudwatch_log_group_name1_arn, var.cloudwatch_log_group_name2_arn],
     "Effect": "Allow"
   }
 ]
}
)
}
 

resource "aws_iam_policy" "ftp-lambda-secret-policy" {
  name        = "ftp-lambda-secret-policy"
  description = "Policy for allow Lambda to retrieve the secret from Secret Manager"
  
  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"  
        ],
        Effect   = "Allow",
        Resource = [var.secret-manager-name1-arn, var.secret-manager-name2-arn],
      },
    ],
  })
}

resource "aws_iam_policy" "ftp-lambda-s3-bucket" {
  name        = "ftp-lambda-s3-bucket"
  description = "Policy for grant permission of Lambda to s3 bucket"
  
  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = var.s3bucket-arn,
      },
    ],
  })
}

resource "aws_iam_policy" "ftp-lambda-sqs-queue" {
  name        = "ftp-lambda-sqs-queue"
  description = "Grant Lambda permisssion to SQS queue"
  
  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Effect   = "Allow",
        Resource = var.sqs_arn,
      },
    ],
  })
}

resource "aws_iam_policy" "ftp-lambda-dead-sqs-queue" {
  name        = "ftp-lambda-dead-sqs-queue"
  description = "Grant Lambda permisssion to Dead SQS queue"
  
  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:SendMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ReceiveMessage"
        ],
        Effect   = "Allow",
        Resource = var.sqs_dead_arn,
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ftp-lambda-policy-s3-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.ftp-lambda-s3-bucket.arn
}

resource "aws_iam_role_policy_attachment" "ftp-lamda-policy-cloudwatch-logs-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.ftp-lamda-policy-cloudwatch-logs.arn
}
 
resource "aws_iam_role_policy_attachment" "ftp-lambda-secret-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.ftp-lambda-secret-policy.arn
}

resource "aws_iam_role_policy_attachment" "ftp-lambda-sqs-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.ftp-lambda-sqs-queue.arn
}

resource "aws_iam_role_policy_attachment" "ftp-lambda-dead-sqs-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.ftp-lambda-dead-sqs-queue.arn
}