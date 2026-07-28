locals {
  # Step 1 - create dictionary of replacement values
  replacements = {
    "micro" = "t2.micro"
    "nano"  = "t3.nano"
  }

  # Step 2 - get csv into terraform blocks
  ec2_info = csvdecode(file("${path.module}/ec2.csv"))


  # Step 3 - replace row title with lower()
  ec2_info_lower = [
    for row in local.ec2_info : {
      for k, v in row : lower(k) => v
    }
  ]

  # Step 4 - replace instance values 
  # Merge() is better than replace() here<F6><F6><F6><F6>, using a dictionary/map with lookup)
  ec2_options = [
    for row in local.ec2_info_lower : merge(row, {
      # lookup() replaces the row.instance_type value if matched; 
      # defaults to original row.instance_type value if not found
      instance_type = lookup(local.replacements, row.instance_type, row.instance_type)
    })
  ]

  # Step 5 - replace us-east-1 servers only
  servers = [
    for row in local.ec2_options :
    row if row.region == "us-east-1"
  ]
}
