variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "JSON string for the assume role policy"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM inline policy"
  type        = string
}

variable "policy_document" {
  description = "JSON string for the inline policy"
  type        = string
}

variable "policy_arn" {
  description = "ARN of the managed policy to attach (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the IAM resources"
  type        = map(string)
  default     = {}
}
