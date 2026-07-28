resource "aws_instance" "this" {
  count         = length(local.servers)
  ami           = local.servers[count.index].ami_id
  instance_type = local.servers[count.index].instance_type

  tags = {
    Name = local.servers[count.index].team_name
  }
}
