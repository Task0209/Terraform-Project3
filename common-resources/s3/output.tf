
output access_control_list {
  description = "Types of access control list"
  value = aws_s3_bucket_acl.access-control.acl
}

output s3bucket {
  description = "Name of s3 buckets"
  value = aws_s3_bucket.impex-booking-request-s3bucket.bucket
}

output s3bucket-arn {
  description = "ARN of s3 buckets"
  value = aws_s3_bucket.impex-booking-request-s3bucket.arn
}

