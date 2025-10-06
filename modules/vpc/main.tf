resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "VPC-${var.project_name}"
  })
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "Public1-${var.az1}" })
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "Public2-${var.az2}" })
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "Private1-${var.az1}" })
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "Private2-${var.az2}" })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "IGW-${var.project_name}" })
}

resource "aws_nat_gateway" "gw1" {
  allocation_id = var.nat1_eip
  subnet_id     = aws_subnet.public1.id
  tags          = merge(var.tags, { Name = "NAT1-${var.project_name}" })
}

resource "aws_nat_gateway" "gw2" {
  allocation_id = var.nat2_eip
  subnet_id     = aws_subnet.public2.id
  tags          = merge(var.tags, { Name = "NAT2-${var.project_name}" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = merge(var.tags, { Name = "RT-Public" })
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw1.id
  }
  tags = merge(var.tags, { Name = "RT-Private1" })
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw2.id
  }
  tags = merge(var.tags, { Name = "RT-Private2" })
}

