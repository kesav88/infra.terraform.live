variable "is_enabled" {
  description = "Flag to enable or disable the KMS module"
  type        = bool
  default     = true
}

variable "multi_region" {
  description = "Flag to enable or disable multi-region key"
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "The intended use of the key. Valid values are ENCRYPT_DECRYPT or SIGN_VERIFY"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "deletion_window_in_days" {
  description = "The waiting period before the KMS key is deleted. Valid values are between 7 and 30 days"
  type        = number
  default     = 7
}

variable "enable_key_rotation" {
  type = bool
  default = true
}

variable "tags" {
    description = "A map of tags to assign to the KMS key"
    type        = map(string)
    default     = {}
}

variable "alias" {
    description = "The alias name for the KMS key"
    type        = string
    default     = "kms-key-test"
}