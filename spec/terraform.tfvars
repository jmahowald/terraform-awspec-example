terragrunt = {
   terraform = {
     source = "${path_relative_from_include()}/../terraform/${path_relative_to_include()}"
   }
}

aws_region="us-west-1"