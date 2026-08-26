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
  source           = "../modules/vpc"
  for_each         = var.vpc
  vpc_cidr         = each.value.cidr
  vpc_name         = each.key
  vpc_subnet_cidr1 = each.value.subnet_cidr1
  vpc_subnet_cidr2 = each.value.subnet_cidr2
}

module "sg" {
  source     = "../modules/sg"
  subnet1_id = data.aws_subnet.subnet_id["subnet-8e1b86492520b2faa"].id
  subnet2_id = data.aws_subnet.subnet_id["subnet-fafc40e1c236353c8"].id
  vpc_id     = data.aws_vpc.challenge-5-vpc.id
}

module "ec2" {
  source        = "../modules/ec2"
  for_each      = data.aws_subnet.subnet_id
  ec2_name      = "HelloWorld"
  ec2_subnet_id = each.value.id
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
  from = aws_security_group.app-1-sg
  to   = module.sg.aws_security_group.app-1-sg
}

moved {
  from = aws_security_group.app-2-sg
  to   = module.sg.aws_security_group.app-2-sg
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
  from = aws_instance.example["subnet-8e1b86492520b2faa"]
  to   = module.ec2["subnet-8e1b86492520b2faa"].aws_instance.example
}

moved {
  from = aws_instance.example["subnet-fafc40e1c236353c8"]
  to   = module.ec2["subnet-fafc40e1c236353c8"].aws_instance.example
}

moved {
  from = aws_subnet.random["subnet1"]
  to   = module.vpc["random-vpc"].aws_subnet.challenge_5["subnet1"]
}

moved {
  from = aws_subnet.random["subnet2"]
  to   = module.vpc["random-vpc"].aws_subnet.challenge_5["subnet2"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.app-1-sg["443"]
  to   = module.sg.aws_vpc_security_group_ingress_rule.app-1-sg["443"]
}

moved {
  from = aws_vpc_security_group_ingress_rule.app-1-sg["80"]
  to   = module.sg.aws_vpc_security_group_ingress_rule.app-1-sg["80"]
}

moved {
  from = aws_vpc_security_group_egress_rule.app-2-sg["8443"]
  to   = module.sg.aws_vpc_security_group_egress_rule.app-2-sg["8443"]
}

moved {
  from = aws_vpc_security_group_egress_rule.app-2-sg["9000"]
  to   = module.sg.aws_vpc_security_group_egress_rule.app-2-sg["9000"]
}

