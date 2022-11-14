terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }

  backend "s3" {
    bucket         = "state20221024120530675700000001"
    key            = "application/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  default_tags {
    tags = {
      From = "Emanuel"
    }
  }
}
