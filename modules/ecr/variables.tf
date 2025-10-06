variable "name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}

variable "encryption_type" {
  description = "The encryption type for the ECR repository"
  type        = string
  default     = "AES256"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the ECR repository"
  type        = map(string)
  default     = {}
}
