resource "aws_s3_bucket" "impex-booking-request-s3bucket" {
  bucket = "${var.s3bucket}"

}

resource "aws_s3_bucket_ownership_controls" "impex-booking-request-owner" {
  bucket = aws_s3_bucket.impex-booking-request-s3bucket.id
  rule {
    object_ownership = "${var.OwnerShip-Permission}"
  }
}

resource "aws_s3_bucket_acl" "access-control" {
  depends_on = [aws_s3_bucket_ownership_controls.impex-booking-request-owner]

  bucket = aws_s3_bucket.impex-booking-request-s3bucket.id
  acl    = "${var.access_control_list}"
}

resource "aws_lambda_permission" "ftp_lambda_s3_permission" {
  statement_id  = "AllowS3InvokeLambda1"
  action        = "lambda:InvokeFunction"
  function_name = "${var.ftp-lamda-name}"
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.impex-booking-request-s3bucket.arn
}

resource "aws_lambda_permission" "submission_lambda_s3_permission" {
  statement_id  = "AllowS3InvokeLambda2"
  action        = "lambda:InvokeFunction"
  function_name = "${var.submission-lambda-name}"
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.impex-booking-request-s3bucket.arn
}
