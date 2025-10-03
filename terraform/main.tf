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

resource "aws_subnet" "main" {
  vpc_id                  = "vpc-07a8c9cc4874997d8"
  cidr_block              = "10.133.56.64/27"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = {
    Country  = "Espana"
    Name     = "10.133.56.64/27-Public1-eu-west-1a"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}