resource "aws_vpc" "main" {
  cidr_block           = "10.133.56.0/25"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name     = "10.133.56.0/25-VPC-ONE-Journey-Dev"
    Country  = "Espana"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}
