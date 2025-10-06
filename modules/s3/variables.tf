variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Whether to allow bucket deletion even if it contains objects"
  type        = bool
  default     = false
}

variable "owner_id" {
  description = "Canonical ID of the bucket owner"
  type        = string
}

variable "versioning_status" {
  description = "Status of versioning (Enabled or Disabled)"
  type        = string
  default     = "Disabled"
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "bucket_key_enabled" {
  description = "Whether bucket key encryption is enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
