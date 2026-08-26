resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "challenge_5" {
  for_each = {
    subnet1 = { cidr = var.vpc_subnet_cidr1, az = "us-east-1a" }
    subnet2 = { cidr = var.vpc_subnet_cidr2, az = "us-east-1b" }
  }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "subnet-${each.key}"
  }
}

