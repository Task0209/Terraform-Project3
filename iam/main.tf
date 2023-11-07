# Create IAM Roles

resource "aws_iam_instance_profile" "impex-ec2-profile" {
name = "${var.impex-profile}"
role = aws_iam_role.impex-ec2-role.name
}

resource "aws_iam_policy" "impex-ec2-policy" {
  name = "impex-ec2-policy"
  path        = "/"
  description = "Grant permission to allow ec2 instance connect,serial console & System manager console"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
  
        Effect = "Allow"
        Action = [
          "ec2:RunInstances",
          "ec2:AssociateIamInstanceProfile",
          "ec2:ReplaceIamInstanceProfileAssociation"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "iam:ListInstanceProfiles",
          "iam:PassRole"
        ],
        Resource = "*"
      },
      {
        "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
      },
      {
        "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
      },
      {
        "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "impex-ec2-role" {
  name = "${var.impex-role}"
  description = "The role for the developer resources EC2"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_policy_attachment" "impex-ec2-policy" {
  name      = "impex-ec2-policy"
  roles     = [aws_iam_role.impex-ec2-role.name]
  policy_arn = aws_iam_policy.impex-ec2-policy.arn
}

# create S3 bucket policy
resource "aws_iam_policy" "impex-s3-bucket" {
  name        = "impex-s3-bucket"
  description = "Policy for grant permission to access the s3 bucket"
  
  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Effect   = "Allow",
        Resource = var.s3bucket-arn,
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "impex_s3_policy-docs" {
 role        = aws_iam_role.impex-ec2-role.name
 policy_arn  = aws_iam_policy.impex-s3-bucket.arn
}

# Create Iam User

resource "aws_iam_user" "impex_user" {
  name = "${var.impex_user}"

}

# Create Access Key and Secret Key for IAM User
resource "aws_iam_access_key" "impex_user_key_pairs" {
  user = aws_iam_user.impex_user.name
}

# Store Access Key and Secret Key in AWS SSM
resource "aws_ssm_parameter" "impex_user_access_key" {
  name        = "${var.imp-acckey}"
  description = "Access key for Impex User"
  type        = "SecureString"
  value       = aws_iam_access_key.impex_user_key_pairs.id

}

resource "aws_ssm_parameter" "impex_user_secret_key" {
  name        = "${var.imp-seckey}"
  description = "Secret Key for Impex User"
  type        = "SecureString"
  value       = aws_iam_access_key.impex_user_key_pairs.secret
}

# Policies assigned to IAM user

resource "aws_iam_user_policy_attachment" "impex_iam_policy_attachment1" {
  user       = aws_iam_user.impex_user.name
  policy_arn = aws_iam_policy.impex-ec2-policy.arn
}

resource "aws_iam_user_policy_attachment" "impex_iam_policy_attachment2" {
  user       = aws_iam_user.impex_user.name
  policy_arn = aws_iam_policy.impex-s3-bucket.arn
}