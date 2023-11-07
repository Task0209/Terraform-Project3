output s3bucket-arn {
  description = "ARN of s3 bucket"
  value = aws_s3_bucket.impex-booking-request-s3bucket.arn
}

output s3bucket {
  description = "Name of s3 bucket"
  value = aws_s3_bucket.impex-booking-request-s3bucket.bucket
}



