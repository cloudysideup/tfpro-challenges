#* Define only a single `aws_instance` resource block. Use `for_each` iterate over data as necessary to create two EC2 instances
#
#  * One EC2 in `subnet-subnet1` (whose subnet id was fetched in Task 2).
#  * Second EC2 in `subnet-subnet2`(whose subnet id was fetched in Task 2).
#
#> [!NOTE]
#> You need to reference to subnet_id by querying data source. No hardcoding.
#
