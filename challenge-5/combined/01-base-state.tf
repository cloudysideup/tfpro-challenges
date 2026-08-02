# apply this first then create other tasks

data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../base-folder/terraform.tfstate"
  }
}
