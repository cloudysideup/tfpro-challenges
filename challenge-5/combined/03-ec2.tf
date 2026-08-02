#* Define only a single `aws_instance` resource block. Use `for_each` iterate over data as necessary to create two EC2 instances
#
#  * One EC2 in `subnet-subnet1` (whose subnet id was fetched in Task 2).
#  * Second EC2 in `subnet-subnet2`(whose subnet id was fetched in Task 2).
#
#> [!NOTE]
#> You need to reference to subnet_id by querying data source. No hardcoding.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  for_each      = toset(data.aws_subnets.challenge-5-subnets.ids)
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = each.key

  tags = {
    Name = "HelloWorld"
  }
}
