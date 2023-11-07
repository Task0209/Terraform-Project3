resource "aws_s3_bucket" "impex-aus-bucket" {
  bucket = "impex-aus-bucket"

}

resource "aws_s3_bucket_ownership_controls" "impex-owner" {
  bucket = aws_s3_bucket.impex-aus-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.impex-owner]

  bucket = aws_s3_bucket.impex-aus-bucket.id
  acl    = "private"
}