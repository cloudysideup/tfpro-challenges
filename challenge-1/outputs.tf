output "s3_buckets" {
  value = aws_s3_bucket.example[*]
}

output "sg_id" {
  value = aws_security_group.example.id
}

output "sg_rule_id" {
  value = aws_vpc_security_group_ingress_rule.example.security_group_rule_id
}

output "user_names" {
  value = aws_iam_user.lb[*]
}


#   s3_buckets = [
#      + "fancy-mouse-kplabs-1",
#      + "fancy-mouse-kplabs-2",
#    ]
#
#   sg_id      = "sg-05da12b59833d3732"
#   sg_rule_id = "sgr-009eccddbf2a81873"
#
#   user_names = [
#      + "fancy-mouse-var.org-name-0",
#      + "fancy-mouse-var.org-name-1",
#      + "fancy-mouse-var.org-name-2",
#    ]
#
