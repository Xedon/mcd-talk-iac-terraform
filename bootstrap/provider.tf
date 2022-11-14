terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }

  // Commenting backend on first apply and then 
  // replace buket name with `state_bucket_name` output
  // and call make bootstrap-migrate
  // backend "s3" {
  //   bucket         = "state20221024120530675700000001"
  //   key            = "bootstrap/terraform.tfstate"
  //   region         = "eu-central-1"
  //   dynamodb_table = "terraform-state-lock"
  //   encrypt        = true
  // }

}


