# get remote state from base-folder first then create these
# apply one block at a time to pull in values

data "aws_vpc" "challenge-5-vpc" {
  id = data.terraform_remote_state.base.outputs.vpc_id
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

#data "aws_subnet" "subnet_ids" {
#  for_each = toset(data.aws_subnets.subnets.ids)
#  id       = each.value
#}

#output "subnet_cidr_blocks" {
#  value = [for s in toset(data.aws_subnets.challenge-5-subnets.ids) : s.cidr_block]
#}
#
#output "subnet_ids" {
#  value = [for s in toset(data.aws_subnets.challenge-5-subnets.ids) : s.id]
#}
