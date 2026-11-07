locals {
  account_id = "175546876384"
}

data "aws_iam_policy_document" "kms_key_policy" {
  statement {
    actions   = ["kms:*"]
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }
}