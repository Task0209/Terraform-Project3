# Create Backup Vault

resource "aws_backup_vault" "vault_impex_aus" {
  name        = "Impex_backup_vault"
  kms_key_arn = aws_kms_key.vault-key-impex-aus.arn
}

# Create Backup Vault Key

resource "aws_kms_key" "vault-key-impex-aus" {
  description         = "Impex KMS Keys for Data Encryption"
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled
  enable_key_rotation      = var.rotation_enabled  

  tags = {
    Name = "impex_kms_key"
  }
}

# Create Backup Plan
resource "aws_backup_plan" "impex_aux_backup_plan" {
  name = "impex_aux_backup_plan"

  rule {
    rule_name         = "impex_aux_backup_rule"
    target_vault_name = aws_backup_vault.vault_impex_aus.name
    schedule          = "cron(0 * ? * * *)"
    start_window      = 60
    completion_window = 300

  }
}

# Create backup selection
resource "aws_backup_selection" "impex_aux_backup_selection" {
  iam_role_arn = aws_iam_role.impex-aux-iam-backup-role.arn
  name         = "impex_aux_backup_selection"
  plan_id      = aws_backup_plan.impex_aux_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup"
    value = "true"
  }
}