data "aws_vpc" "challenge-5-vpc" {
  id = module.vpc["challenge-5-vpc"].vpc_id
  filter {
    name   = "tag:Name"
    values = ["challenge-5-vpc"]
  }
}

data "aws_subnets" "challenge-5-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.challenge-5-vpc.id]
  }
}

data "aws_subnet" "subnet_id" {
  for_each = toset(data.aws_subnets.challenge-5-subnets.ids)
  id       = each.value
}

module "vpc" {
  source           = "../../modules/vpc"
  for_each         = var.vpc
  vpc_cidr         = each.value.cidr
  vpc_name         = each.key
  vpc_subnet_cidr1 = each.value.subnet_cidr1
  vpc_subnet_cidr2 = each.value.subnet_cidr2
}


moved {
  from = aws_vpc.main
  to   = module.vpc["challenge-5-vpc"].aws_vpc.main
}

moved {
  from = aws_vpc.random
  to   = module.vpc["random-vpc"].aws_vpc.main
}

moved {
  from = aws_subnet.challenge_5["subnet1"]
  to   = module.vpc["challenge-5-vpc"].aws_subnet.challenge_5["subnet1"]
}

moved {
  from = aws_subnet.challenge_5["subnet2"]
  to   = module.vpc["challenge-5-vpc"].aws_subnet.challenge_5["subnet2"]
}

moved {
  from = aws_subnet.random["subnet1"]
  to   = module.vpc["random-vpc"].aws_subnet.challenge_5["subnet1"]
}

moved {
  from = aws_subnet.random["subnet2"]
  to   = module.vpc["random-vpc"].aws_subnet.challenge_5["subnet2"]
}
