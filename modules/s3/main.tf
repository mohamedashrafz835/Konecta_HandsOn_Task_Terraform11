##########################
# S3 Bucket Module Logic #
##########################

# Main bucket
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}

# ACL (optional – only if needed)
resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id

  access_control_policy {
    owner {
      id = var.owner_id
    }

    grant {
      permission = "FULL_CONTROL"

      grantee {
        id   = var.owner_id
        type = "CanonicalUser"
      }
    }
  }
}

# Versioning
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_status
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    bucket_key_enabled = var.bucket_key_enabled

    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}
