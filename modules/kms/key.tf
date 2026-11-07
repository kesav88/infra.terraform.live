locals {
    alias = "kms-key-test"
}

resource "aws_kms_key" "this" {
  is_enabled              = var.is_enabled
  multi_region            = var.multi_region
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  tags                    = var.tags
  policy                  = data.aws_iam_policy_document.kms_key_policy.json
}

resource "aws_kms_alias" "kms-alias" {
    name          = "alias/${var.alias}"
    target_key_id = aws_kms_key.this.key_id
  
}