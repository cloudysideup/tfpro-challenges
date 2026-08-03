#### Task 5 - Create  Security Group Rules
#
#Refer to the contents of the `sg.csv` file and create security group rule based on following conditions:
#
#1. Use a single `aws_vpc_security_group_ingress_rule` resource block to create 
#   security group inbound rules for `app-1-sg` security group. 
#
# * If `description` in CSV is `app-1`, the rule must be associated with 
# `app-1-sg` security group. Only consider inbound rules, the outbound rules should be ignored.
#
#2. Use a single `aws_vpc_security_group_egress_rule` 
#  resource block to create security group egress rules for `app-2-sg` security group.
#
# * If `description` in CSV is `app-2`, the rule must be associated with `app-2-sg` security group. 
#   Only consider outbound rules, the inbound rules should be ignored.
#
#> [!IMPORTANT]  
##> Use the `for_each` and `for expression` to iterate over the contents of CSV files to fetch necessary data.

locals {

  sg_rules = csvdecode(file("../base-folder/sg.csv"))

  sg_rules_in_app1 = [for rule in local.sg_rules : rule if rule.description == "app-1" && rule.direction == "in"]

  sg_rules_out_app2 = [for rule in local.sg_rules : rule if rule.description == "app-2" && rule.direction == "out"]

}
