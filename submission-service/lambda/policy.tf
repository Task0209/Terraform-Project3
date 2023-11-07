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
resource "aws_iam_policy" "lamda-cloudwatch-logs-policy" {
 
 name         = "lamda-cloudwatch-logs-policy"
 path         = "/"
 description  = "AWS IAM Policy for managing submission aws lambda role"
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
 

resource "aws_iam_policy" "lambda-secret-policy" {
  name        = "lambda-secret-policy"
  description = "Policy for allow Lambda to retrieve the secret from Secret Manager"
  
  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"   # Add any additional actions you need
        ],
        Effect   = "Allow",
        Resource = [var.secret-manager-name1-arn, var.secret-manager-name2-arn],
      },
    ],
  })
}


resource "aws_iam_policy" "lambda-s3-bucket-policy" {
  name        = "lambda-s3-bucket-policy"
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

resource "aws_iam_policy" "lambda-sqs-queue-policy" {
  name        = "lambda-sqs-queue-policy"
  description = "Policy that allows Lambda to send messages to an SQS queue"
  
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

resource "aws_iam_role_policy_attachment" "lamda-cloudwatch-logs-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.lamda-cloudwatch-logs-policy.arn
}
 
resource "aws_iam_role_policy_attachment" "lambda-secret-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.lambda-secret-policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda-s3-bucket-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.lambda-s3-bucket-policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda-sqs-queue-policy-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.lambda-sqs-queue-policy.arn
}
 
