This project is a sample of using awsspec and terragrunt to have more Behavior Driven Design (BDD) with
your terraform projects.  

Do a `./kitchen test` to have a vpc stood up (warning, test will first destroy anything you've already created with test kitchen), have behavior tests run against it and tear down if everything is succesfull.  Or do `./kitchen converge` to create the infrastructure,run `kitchen verify` to test without being destructive to do some manual investigation, and  run `kitchen destroy` when done