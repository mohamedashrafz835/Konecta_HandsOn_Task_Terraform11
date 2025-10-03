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

resource "aws_subnet" "main2" {
  vpc_id                  = "vpc-07a8c9cc4874997d8"
  cidr_block              = "10.133.56.0/27"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = {
    Country  = "Espana"
    Name     = "10.133.56.0/27-Private1-eu-west-1a"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_subnet" "main3" {
  vpc_id                  = "vpc-07a8c9cc4874997d8"
  cidr_block              = "10.133.56.32/27"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = {
    Country  = "Espana"
    Name     = "10.133.56.32/27-Private2-eu-west-1b"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_subnet" "main4" {
  vpc_id                  = "vpc-07a8c9cc4874997d8"
  cidr_block              = "10.133.56.96/27"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = {
    Country  = "Espana"
    Name     = "10.133.56.96/27-Public2-eu-west-1b"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = "vpc-07a8c9cc4874997d8"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "nat-06e0fae801fb51415"
  }

  tags = {
    Country  = "Espana"
    Name     = "RT-Private2"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_route_table" "private1" {
  vpc_id = "vpc-07a8c9cc4874997d8"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "nat-056d26997c2efb49d"
  }

  tags = {
    Country  = "Espana"
    Name     = "RT-Private1"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_route_table" "public1" {
  vpc_id = "vpc-07a8c9cc4874997d8"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0520f16d01b04bbce"
  }

  tags = {
    Country  = "Espana"
    Name     = "RT-Public1"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_route_table" "public2" {
  vpc_id = "vpc-07a8c9cc4874997d8"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0520f16d01b04bbce"
  }

  tags = {
    Country  = "Espana"
    Name     = "RT-Public2"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_nat_gateway" "gw1" {
  allocation_id = "eipalloc-0125eeaeeb3ed5378"
  subnet_id     = "subnet-078739331b8ff8b6f"

  tags = {
    Country  = "Espana"
    Name     = "NAT-ONE-Journey-Dev-2"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_nat_gateway" "gw2" {
  allocation_id = "eipalloc-03c0f299953fa6cde"
  subnet_id     = "subnet-0da11ba137923c147"

  tags = {
    Country  = "Espana"
    Name     = "NAT-ONE-Journey-Dev-1"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "vpc-07a8c9cc4874997d8"

  tags = {
    Country  = "Espana"
    Name     = "IGW-ONE-Journey-Dev"
    Platform = "Terraform"
    Project  = "ONE Journey Dev"
  }
}





resource "aws_security_group" "main" {
  name        = "OJECSSecurityGroupLB-dev"
  description = "OJECSSecurityGroupLB-dev"
  vpc_id      = "vpc-07a8c9cc4874997d8"

  ingress {
    description = "Free Ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    OJ    = "OJ"
    STAGE = "dev"
  }
}


resource "aws_s3_bucket" "main" {
  bucket = "amaya-logs"
}

# Main S3 bucket resource
resource "aws_s3_bucket" "main1" {
  bucket = "cf-templates-11mxdb199vu4y-eu-west-1"

  tags = {
    # Add your tags here if needed
  }
}

resource "aws_s3_bucket_acl" "main1" {
  bucket = aws_s3_bucket.main1.id

  access_control_policy {
    owner {
      id = "e65b8be90b02e3c981860e80965f9ea93006d3a6431b4428f4d4c8ee1baf47bc"
    }

    grant {
      permission = "FULL_CONTROL"

      grantee {
        id   = "e65b8be90b02e3c981860e80965f9ea93006d3a6431b4428f4d4c8ee1baf47bc"
        type = "CanonicalUser"
      }
    }
  }
}


# Versioning must be managed separately
resource "aws_s3_bucket_versioning" "main1" {
  bucket = aws_s3_bucket.main1.id

  versioning_configuration {
    status = "Disabled"
  }
}

# Server-side encryption must be managed separately
resource "aws_s3_bucket_server_side_encryption_configuration" "main1" {
  bucket = aws_s3_bucket.main1.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}




