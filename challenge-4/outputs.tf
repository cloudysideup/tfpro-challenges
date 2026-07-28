#Instance ID
output "instance_id" {
  value = aws_instance.this[*].id
}

#Region
output "ec2_region" {
  value = local.servers[*].region
}

#Team name
output "ec2_team_name" {
  value = aws_instance.this[*].tags.Name
}

#Instance type
output "ec2_instance_type" {
  value = aws_instance.this[*].instance_type
}

output "aws_instance_info" {
  value = {
    "id"          = aws_instance.this[*].id
    "region"      = local.servers[*].region
    "subnet"      = "subnet"
    "team"        = aws_instance.this[*].tags.Name
    "type"        = aws_instance.this[*].instance_type
    "firewall_id" = toset([])
  }
}
