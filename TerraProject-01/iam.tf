# Create IAM Roles

resource "aws_iam_instance_profile" "impex-aus-ec2-iam-profile" {
name = "ec2_profile"
role = aws_iam_role.impex-aus-ec2-iam-role.name
}

resource "aws_iam_policy" "impex-aus-ec2-iam-policy" {
  name = "ec2_policy"
  path = "/"
  description = "Policy to provide permission to EC2"
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

resource "aws_iam_role" "impex-aus-ec2-iam-role" {
  name = "ec2_role"
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


resource "aws_iam_policy_attachment" "test-attachimpex-aus-ec2-iam-policy" {
  name      = "ec2-policy"
  roles     = [aws_iam_role.impex-aus-ec2-iam-role.name]
  policy_arn = aws_iam_policy.impex-aus-ec2-iam-policy.arn
}

