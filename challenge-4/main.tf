resource "aws_instance" "this" {
  count         = length(local.servers)
  ami           = local.servers[count.index].AMI_ID
  instance_type = local.servers[count.index].instance_type

  tags = {
    Name = local.servers[count.index].Team_Name
  }
}
