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

