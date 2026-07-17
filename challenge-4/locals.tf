locals {
  # get csv into terraform blocks
  ec2_info = csvdecode(file("${path.module}/ec2.csv"))

  # create dictionary
  replacements = {
    "micro" = "t2.micro"
    "nano"  = "t3.nano"
  }

  # replace instance values (better, using a dictionary/map with lookup)
  ec2_options = [
    for row in local.ec2_info : merge(row, {
      # lookup() replaces the value if matched; defaults to original row value if not found
      instance_type = lookup(local.replacements, row.instance_type, row.instance_type)
    })
  ]

  #replace instance values (not ideal but fits scenario and data)
  # ec2_instance_options = [
  #  for row in local.ec2_info :
  #  row.instance_type == "micro" ? merge(row, { instance_type = "t2.micro" }) : merge(row, { instance_type = "t3.nano" })
  #]

  #us-east-1 servers only

  servers = [
    for row in local.ec2_options :
    row if row.Region == "us-east-1"
  ]

}
