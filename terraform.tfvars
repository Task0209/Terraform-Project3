region          = "us-east-1"
env = "qa"
service = "impex-booking-request"
ver = "v1"
kms_key_name = "qa-us-east-1-booking-request-kmskey-v1"
usage = "ENCRYPT_DECRYPT"
key_spec = "SYMMETRIC_DEFAULT"
impex_user_arn = "arn:aws:iam::266842636661:user/ubuntu"
OwnerShip-Permission = "BucketOwnerPreferred"
access_control_list = "private"
retention_period = 86400
visibility_timeout = 60
delay_sec = 5
max_msg_sz = 2048
receive_wait_sec = 2
rec_win_in_days = 7
receive_count = 3
lamda-handler = "impex.lambda_handler"



