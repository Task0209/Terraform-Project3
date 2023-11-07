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

