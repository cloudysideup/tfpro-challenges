data "aws_vpc" "challenge-5-vpc" {
  id = aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["challenge-5-vpc"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.challenge-5-vpc.id]
  }
}

data "aws_subnet" "subnet_ids" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.subnet_ids : s.cidr_block]
}

output "subnet_ids" {
  value = [for s in data.aws_subnet.subnet_ids : s.id]
}
