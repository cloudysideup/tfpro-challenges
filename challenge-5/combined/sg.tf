#TODO enumerate for_each

#### Task 4 - Create Security Group
#
#* Create a new file `sg.tf` in the base-folder.
#
#* Define a single `aws_security_group` resource block using `for_each` to create two security groups:
#   * app-1-sg.
#   * app-2-sg.
#
#* Ensure the security groups are created in the `challenge-5-vpc`
#
#
#### Task 5 - Create  Security Group Rules
#
#Refer to the contents of the `sg.csv` file and create security group rule based on following conditions:
#
#1. Use a single `aws_vpc_security_group_ingress_rule` resource block to create security group inbound rules for `app-1-sg` security group. 
#
#* If `description` in CSV is `app-1`, the rule must be associated with `app-1-sg` security group. Only consider inbound rules, the outbound rules should be ignored.
#
#2. Use a single `aws_vpc_security_group_egress_rule` resource block to create security group egress rules for `app-2-sg` security group.
#
#* If `description` in CSV is `app-2`, the rule must be associated with `app-2-sg` security group. Only consider outbound rules, the inbound rules should be ignored.
#
#> [!IMPORTANT]  
#> Use the `for_each` and `for expression` to iterate over the contents of CSV files to fetch necessary data.

resource "aws_security_group" "allow_tls" {
  for_each    = data.aws_subnet.subnet_ids.id
  name        = "app-${each.key}-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.challenge-5-vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_ingress_rule" "app-1-sg" {
  for_each          = local.csv_info_app1
  security_group_id = aws_security_group.allow_tls["app-1-sg"].id
  cidr_ipv4         = each.value.cidr_block
  from_port         = ["*"]
  ip_protocol       = each.value.protocol
  to_port           = each.value.port

  tags = {
    Name = each.value.name
  }

}

resource "aws_security_group_ingress_rule" "app-2-sg" {
  for_each          = local.csv_info_app2
  security_group_id = aws_security_group.allow_tls["app-2-sg"].id
  cidr_ipv4         = each.value.cidr_block
  from_port         = ["*"]
  ip_protocol       = each.value.protocol
  to_port           = each.value.port

  tags = {
    Name = each.value.name
  }

}
