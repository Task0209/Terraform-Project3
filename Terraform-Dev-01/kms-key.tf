resource "aws_kms_key" "impex_kms_key_aus" {
  description         =  "KMS Keys for Data Encryption of Booking service"
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled
  deletion_window_in_days  = 7
  enable_key_rotation      = var.rotation_enabled
  multi_region        = true
  tags = {
    Name = "impex_kms_key_aus"
  }
}

resource "aws_kms_alias" "impex_kms_key" {
  target_key_id = aws_kms_key.impex_kms_key_aus.id
  name          = "alias/kms/impex_kms_key"
}

resource "aws_kms_replica_key" "impex_kms_key_us" {
  provider = aws.secondary

  description             = "KMS Key for US"
  deletion_window_in_days = 7
  primary_key_arn         = aws_kms_key.impex_kms_key_aus.arn
}

resource "aws_kms_replica_key" "impex_kms_key_central" {
  provider = aws.tertiary

  description             = "KMS Key for Canada"
  deletion_window_in_days = 7
  primary_key_arn         = aws_kms_key.impex_kms_key_aus.arn
}