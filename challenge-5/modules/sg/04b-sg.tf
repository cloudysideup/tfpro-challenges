resource "aws_security_group" "app-1-sg" {
  name        = "app-${var.subnet1_id}-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "app-1-sg"
  }
}

resource "aws_security_group" "app-2-sg" {
  name        = "app-${var.subnet2_id}-sg"
  description = "Allow outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "app-2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app-1-sg" {
  for_each          = { for rule in local.sg_rules_in_app1 : rule.port => rule }
  security_group_id = aws_security_group.app-1-sg.id
  cidr_ipv4         = each.value.cidr_block
  from_port         = each.value.port
  ip_protocol       = each.value.protocol
  to_port           = each.value.port

  tags = {
    Name = each.value.name
  }

}

resource "aws_vpc_security_group_egress_rule" "app-2-sg" {
  for_each          = { for rule in local.sg_rules_out_app2 : rule.port => rule }
  security_group_id = aws_security_group.app-2-sg.id
  cidr_ipv4         = each.value.cidr_block
  from_port         = each.value.port
  ip_protocol       = each.value.protocol
  to_port           = each.value.port

  tags = {
    Name = each.value.name
  }

}
