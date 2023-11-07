
resource "aws_iam_policy" "impex_ec2_policy" {
  name = "impex_ec2_policy"
  path = "/"
  description = "Policy to provide permission to EC2"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:RunInstances", 
          "ec2:TerminateInstances", 
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        "Resource": var.instance_arn,
      },
    ]
  })
}

resource "aws_iam_policy" "impex_iam_policy" {
  name = "impex_iam_policy"
  path = "/"
  description = "Grant a user permission to pass an IAM role to an instance"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "iam:PassRole", 
          "iam:ListInstanceProfiles",
          "ec2:AssociateIamInstanceProfile", 
          "ec2:ReplaceIamInstanceProfileAssociation",
        ],
        "Resource": "arn:aws:iam::266842636661:role/DevTeam*",
      },
    ]
  })
}

resource "aws_iam_policy" "impex_ec2_connect_policy" {
  name = "impex_ec2_connect_policy"
  path = "/"
  description = "Grant IAM permissions for EC2 Instance Connect"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2-instance-connect:SendSSHPublicKey", 
          "ec2:DescribeInstances"
        ],
        "Resource": var.instance_arn,
      },
    ]
  })
}

resource "aws_iam_policy" "impex_ec2_system_manager_policy" {
  name = "impex_ec2_system_manager_policy"
  path = "/"
  description = "Grant IAM permissions for EC2 System Manager Access"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
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
          "ssm:UpdateInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        "Resource": var.instance_arn,
      },
    ]
  })
}


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
        Resource = "*",
      },
    ],
  })
}


resource "aws_iam_role" "impex_ec2_role" {
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

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_role_policy_attachment" "impex_ec2_policy-docs" {
 role        = aws_iam_role.impex_ec2_role.name
 policy_arn  = aws_iam_policy.impex_ec2_policy.arn
}

resource "aws_iam_role_policy_attachment" "impex_iam_policy-docs" {
 role        = aws_iam_role.impex_ec2_role.name
 policy_arn  = aws_iam_policy.impex_iam_policy.arn
}
 
resource "aws_iam_role_policy_attachment" "impex_ec2_connect_policy-docs" {
 role        = aws_iam_role.impex_ec2_role.name
 policy_arn  = aws_iam_policy.impex_ec2_connect_policy.arn
}

resource "aws_iam_role_policy_attachment" "impex_ec2_system_manager_policy-docs" {
 role        = aws_iam_role.impex_ec2_role.name
 policy_arn  = aws_iam_policy.impex_ec2_system_manager_policy.arn
}

resource "aws_iam_role_policy_attachment" "impex_s3_bucket_policy-docs" {
 role        = aws_iam_role.impex_ec2_role.name
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
  policy_arn = aws_iam_policy.impex_iam_policy.arn
}

resource "aws_iam_user_policy_attachment" "impex_iam_policy_attachment2" {
  user       = aws_iam_user.impex_user.name
  policy_arn = aws_iam_policy.impex_ec2_policy.arn
}


# Create Instance profile for Newly launched EC2 machine

resource "aws_iam_instance_profile" "impex-ec2-iam-profile" {
name = "${var.impex-profile}"
role = aws_iam_role.impex_ec2_role.name
}

resource "aws_iam_policy_attachment" "impex_ec2_iam_policy-docs1" {
  name      = "impex_ec2_iam_policy-docs1"
  roles     = [aws_iam_role.impex_ec2_role.name]
  policy_arn = aws_iam_policy.impex_ec2_policy.arn
}

resource "aws_iam_policy_attachment" "impex_ec2_iam_policy-docs2" {
  name      = "impex_ec2_iam_policy-docs2"
  roles     = [aws_iam_role.impex_ec2_role.name]
  policy_arn = aws_iam_policy.impex_iam_policy.arn
}

resource "aws_iam_policy_attachment" "impex_ec2_iam_policy-docs3" {
  name      = "impex_ec2_iam_policy-docs3"
  roles     = [aws_iam_role.impex_ec2_role.name]
  policy_arn = aws_iam_policy.impex_ec2_system_manager_policy.arn
}

resource "aws_iam_policy_attachment" "impex_ec2_iam_policy-docs4" {
  name      = "impex_ec2_iam_policy-docs4"
  roles     = [aws_iam_role.impex_ec2_role.name]
  policy_arn = aws_iam_policy.impex_ec2_connect_policy.arn
}

