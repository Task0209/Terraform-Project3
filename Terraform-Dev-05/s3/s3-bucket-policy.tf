resource "aws_s3_bucket_policy" "impex-s3-bucket-policy" {
  bucket = aws_s3_bucket.impex-aus-bucket.id
  policy = data.aws_iam_policy_document.impex-s3-bucket-policy.json
}

data "aws_iam_policy_document" "impex-s3-bucket-policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["266842636661"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.impex-aus-bucket.arn,
      "${aws_s3_bucket.impex-aus-bucket.arn}/*",
    ]
  }
}