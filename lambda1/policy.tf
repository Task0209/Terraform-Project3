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

 
resource "aws_iam_policy" "lambda1-s3-bucket" {
  name        = "lambda1-s3-bucket"
  description = "Policy for allow Lambda to retrieve the secret from Secret Manager"
  
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

resource "aws_iam_role_policy_attachment" "lambda1-policy2-docs" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.lambda1-s3-bucket.arn
}
 
