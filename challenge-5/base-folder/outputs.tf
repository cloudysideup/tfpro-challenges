output "vpc_id" {
  value = resource.aws_vpc.main.id
}

output "subnet_ids" {
  value = data.aws_subnets.challenge-5-subnets.ids
}
