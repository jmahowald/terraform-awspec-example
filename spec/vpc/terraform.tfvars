terragrunt = {
 # terraform = {
  #  source = "../..//terraform/vpc"
 # }
  include {
   path = "${find_in_parent_folders()}"
  }
}

#primary_cidr_block = "10.10.0.0/16"
aws_region="us-east-1"
environment = "citest"