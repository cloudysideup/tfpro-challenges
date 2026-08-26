output "vpc_id" {
  value = module.vpc["challenge-5-vpc"].vpc_id
}

output "subnet_ids" {
  value = data.aws_subnets.challenge-5-subnets.ids
}
