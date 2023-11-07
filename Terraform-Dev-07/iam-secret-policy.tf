data "aws_iam_policy_document" "impex-secret-policy" {
  statement {
    sid    = "EnableAnotherAWSAccountToReadTheSecret"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::266842636661:user/ubuntu"]
    }

    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_secretsmanager_secret_policy" "impex-secret-policy" {
  secret_arn = aws_secretsmanager_secret.impex-cred.arn
  policy     = data.aws_iam_policy_document.impex-secret-policy.json
}

