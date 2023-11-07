resource "aws_kms_key" "impex-booking-request-kmskey" {
  description         =  "KMS Keys for Data Encryption of Booking service"
  customer_master_key_spec = "${var.key_spec}"
  key_usage = "${var.usage}"
  is_enabled               = "${var.enabled}"
  deletion_window_in_days  = var.del_win_in_days
  enable_key_rotation      = "${var.rotation_enabled}"
  tags = {
    Name = "${var.kms_key_name}"
  }
}

