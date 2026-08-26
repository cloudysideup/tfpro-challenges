data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../vpc-infra/terraform.tfstate"
  }
}

module "sg" {
  source     = "../../modules/sg"
  subnet1_id = data.terraform_remote_state.vpc.outputs.subnet_ids[0]
  subnet2_id = data.terraform_remote_state.vpc.outputs.subnet_ids[1]
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
}

module "ec2" {
  source        = "../../modules/ec2"
  for_each      = toset(data.terraform_remote_state.vpc.outputs.subnet_ids)
  ec2_name      = "HelloWorld"
  ec2_subnet_id = each.value
}

import {
  to = module.sg.aws_security_group.app-1-sg
  id = "sg-3150ee585e7ad8947"
}

import {
  to = module.sg.aws_security_group.app-2-sg
  id = "sg-f8867a1bc59469ca9"
}

import {
  to = module.sg.aws_vpc_security_group_ingress_rule.app-1-sg["80"]
  id = "sgr-6cb02f3592db590b1"
}

import {
  to = module.sg.aws_vpc_security_group_ingress_rule.app-1-sg["443"]
  id = "sgr-3ac9ddbdf292d9e6b"
}

import {
  to = module.sg.aws_vpc_security_group_egress_rule.app-2-sg["8443"]
  id = "sgr-8dbcd8aae5a3f3e8c"
}

import {
  to = module.sg.aws_vpc_security_group_egress_rule.app-2-sg["9000"]
  id = "sgr-3a27363c761ce45bd"
}

import {
  to = module.ec2["subnet-8e1b86492520b2faa"].aws_instance.example
  id = "i-c55924d94546318d4"
}

import {
  to = module.ec2["subnet-fafc40e1c236353c8"].aws_instance.example
  id = "i-cfa15e96e22acc66e"
}
