locals {
  config2 = yamldecode(file("conf.yaml"))
}

resource "aws_secretsmanager_secret" "impex-cred" {
  name = "impex-cred"
   recovery_window_in_days = 0 // Overriding the default recovery window of 30 days
   kms_key_id = aws_kms_key.impex_kms_key_aus.key_id
}

# Create a random generated password to use in secrets.
 

resource "aws_secretsmanager_secret_version" "impex-secret-version" {
  secret_id = aws_secretsmanager_secret.impex-cred.id
  secret_string = yamlencode(local.config2.secrets.impex-gatepass)
}

