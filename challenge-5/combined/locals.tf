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
##> Use the `for_each` and `for expression` to iterate over the contents of CSV files to fetch necessary data.

locals {

  csv_info = csvdecode(file("../base-folder/sg.csv"))

  csv_info_app1 = [for row in local.csv_info : if row.description == "app-1"]
  csv_info_app2 = [for row in local.csv_info : if row.description == "app-2"]

}
