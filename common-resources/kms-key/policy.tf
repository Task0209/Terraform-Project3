resource "aws_kms_key_policy" "impex-iam-kms-policy" {
  key_id = aws_kms_key.impex-booking-request-kmskey.id
  policy = jsonencode({
    Id = "impex_kms_key"
    Statement = [
      {
        Action = "kms:*"
        Resource = "*"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::266842636661:root"
        }
        Sid      = "Enable IAM User Permissions"
      },
      {
        Action = [
            "kms:Create*",
            "kms:Describe*",
            "kms:Enable*",
            "kms:List*",
            "kms:Put*",
            "kms:Update*",
            "kms:Revoke*",
            "kms:Disable*",
            "kms:Get*",
            "kms:Delete*",
            "kms:TagResource",
            "kms:UntagResource",
            "kms:ScheduleKeyDeletion",
            "kms:CancelKeyDeletion"
        ],
        Resource = "*"
        Effect = "Allow",
        Sid = "Allow access for Key Administrators",
        Principal = {
            AWS = "${var.impex_user_arn}"
        }
      },
      {
        Action = [
            "kms:CreateGrant",
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
          ],
        Effect = "Allow",
        Sid = "Allow other accounts limited access to key",
        Principal = {
            AWS = "${var.impex_user_arn}"
        }
      },
      {
        Action = [
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:RevokeGrant"
          ],
        Effect = "Allow",
        Sid = "Allow attachment of persistent resources",
        Principal = {
            AWS = "${var.impex_user_arn}"
        }
      }
    ]
    Version = "2012-10-17"
  })
}