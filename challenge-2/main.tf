terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = var.environement
    }
  }
}

data "aws_ami" "example" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20260313"]
  }
}

#resource "random_pet" "this" {}

module "random" {
  source = "./random/"
}

moved {
  from = resource.random_pet.this
  to   = module.random.random_pet.this
}

#resource "aws_instance" "this" {
#  #  ami                  = "ami-0ec10929233384c7f"
#  ami                  = data.aws_ami.example.id
#  instance_type        = "t3.micro"
#  iam_instance_profile = aws_iam_instance_profile.test_profile.name
#}

module "ec2" {
  source               = "./ec2/"
  ami                  = data.aws_ami.example.id
  instance_type        = "t3.micro"
  iam_instance_profile = module.iam.iam_instance_profile_name
}

moved {
  from = aws_instance.this
  to   = module.ec2.aws_instance.this
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#resource "aws_iam_role" "test_role" {
#  name               = "ec2-iam-role"
#  assume_role_policy = data.aws_iam_policy_document.assume_role.json
#}
#
#resource "aws_iam_instance_profile" "test_profile" {
#  name = "test_profile"
#  role = aws_iam_role.test_role.name
#}
#
#resource "aws_iam_user" "lb" {
#  count = 3
#  name  = "${module.random.random_id}-${var.org-name}-${count.index}"
#}
#
## This policy must be associated with all IAM users created through this code.
#
#resource "aws_iam_user_policy" "lb_ro" {
#  name  = "ec2-describe-policy"
#  count = 3
#  user  = aws_iam_user.lb[count.index].name
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Action = [
#          "ec2:Describe*",
#        ]
#        Effect   = "Allow"
#        Resource = "*"
#      },
#    ]
#  })
#}
#

module "iam" {
  source                    = "./iam/"
  iam_role_name             = "ec2-iam-role"
  iam_role_assume_policy    = data.aws_iam_policy_document.assume_role.json
  iam_instance_profile_name = "test_profile"
  iam_user_name             = "${module.random.random_id}-${var.org-name}"
}

moved {
  from = aws_iam_role.test_role
  to   = module.iam.aws_iam_role.test_role
}

moved {
  from = aws_iam_instance_profile.test_profile
  to   = module.iam.aws_iam_instance_profile.test_profile
}

moved {
  from = aws_iam_user.lb
  to   = module.iam.aws_iam_user.lb
}

moved {
  from = aws_iam_user_policy.lb_ro
  to   = module.iam.aws_iam_user_policy.lb_ro
}

#resource "aws_s3_bucket" "example" {
#  for_each = var.s3_buckets
#  bucket   = "${module.random.random_id}-${each.value}"
#}
#
#resource "aws_s3_object" "object" {
#  for_each = var.s3_buckets
#  bucket   = aws_s3_bucket.example[each.key].id
#  key      = var.s3_base_object
#}

module "s3" {
  source   = "./s3/"
  for_each = var.s3_buckets
  bucket   = "${module.random.random_id}-${each.value}"
  key      = var.s3_base_object
}

moved {
  from = aws_s3_bucket.example["kplabs-1"]
  to   = module.s3["kplabs-1"].aws_s3_bucket.example
}

moved {
  from = aws_s3_bucket.example["kplabs-2"]
  to   = module.s3["kplabs-2"].aws_s3_bucket.example
}

moved {
  from = aws_s3_object.object["kplabs-1"]
  to   = module.s3["kplabs-1"].aws_s3_object.object
}

moved {
  from = aws_s3_object.object["kplabs-2"]
  to   = module.s3["kplabs-2"].aws_s3_object.object
}

#resource "aws_security_group" "example" {
#  name = var.sg_name
#}
#
#resource "aws_vpc_security_group_ingress_rule" "example" {
#  security_group_id = aws_security_group.example.id
#
#  cidr_ipv4   = "10.0.0.0/8"
#  from_port   = 80
#  ip_protocol = "tcp"
#  to_port     = 80
#}

module "sg" {
  source  = "./sg/"
  sg_name = var.sg_name
}

moved {
  from = aws_security_group.example
  to   = module.sg.aws_security_group.example
}

moved {
  from = aws_vpc_security_group_ingress_rule.example
  to   = module.sg.aws_vpc_security_group_ingress_rule.example
}
