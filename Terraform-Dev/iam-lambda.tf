resource "aws_iam_role_policy" "impex_lambda_policy" {
  name = "impex_lambda_policy"
  role = aws_iam_role.impex_lambda_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("iam/lamba-policy.json")}"
}

resource "aws_iam_role" "impex_lambda_role" {
  name = "impex_lambda_role"

  assume_role_policy = "${file("iam/lamba-assume-policy.json")}"
}