#* Define only a single `aws_instance` resource block. Use `for_each` iterate over data as necessary to create two EC2 instances
#
#  * One EC2 in `subnet-subnet1` (whose subnet id was fetched in Task 2).
#  * Second EC2 in `subnet-subnet2`(whose subnet id was fetched in Task 2).
#
#> [!NOTE]
#> You need to reference to subnet_id by querying data source. No hardcoding.


resource "aws_instance" "example" {
  for_each      = data.aws_subnet.subnet_ids.id
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = each.key

  tags = {
    Name = "HelloWorld"
  }
}
