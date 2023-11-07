# Create IAM Roles

resource "aws_iam_instance_profile" "ec2_profile" {
name = "ec2_profile"
role = aws_iam_role.impex_ec2_role.name
}

resource "aws_iam_policy" "impex_ec2_policy" {
  name = "impex_ec2_policy"
  path = "/"
  description = "Policy to provide permission to EC2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:RunInstances", 
          "ec2:TerminateInstances", 
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        Resource = "arn:aws:ec2:ap-southeast-2:266842636661:instance/*"
      },
    ]
  })
}

resource "aws_iam_policy" "impex_iam_policy" {
  name = "impex_iam_policy"
  path = "/"
  description = "Grant a user permission to pass an IAM role to an instance"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole", 
          "iam:ListInstanceProfiles",
          "ec2:AssociateIamInstanceProfile", 
          "ec2:ReplaceIamInstanceProfileAssociation",
        ],
        Resource = "arn:aws:iam::266842636661:role/DevTeam*"
      },
    ]
  })
}

resource "aws_iam_policy" "impex_ec2_connect_policy" {
  name = "impex_ec2_connect_policy"
  path = "/"
  description = "Grant IAM permissions for EC2 Instance Connect"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2-instance-connect:SendSSHPublicKey", 
          "ec2:DescribeInstances",
        ],
        Resource = "arn:aws:ec2:ap-southeast-2:266842636661:instance/*"
      },
    ]
  })
}

resource "aws_iam_policy" "impex_ec2_system_manager_policy" {
  name = "impex_ec2_system_manager_policy"
  path = "/"
  description = "Grant IAM permissions for EC2 System Manager Access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
        Resource = "arn:aws:ec2:ap-southeast-2:266842636661:instance/*"
      },
    ]
  })
}

resource "aws_iam_role" "impex_ec2_role" {
  name = "impex_ec2_role"
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
  for_each = toset([
    aws_iam_policy.impex_ec2_policy.arn,
    aws_iam_policy.impex_ec2_connect_policy.arn,
    aws_iam_policy.impex_ec2_system_manager_policy.arn
  ])
  roles     = [aws_iam_role.impex_ec2_role.name]
  policy_arn = each.value
}



