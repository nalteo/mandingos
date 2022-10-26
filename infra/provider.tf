provider "aws" {
  region  = "eu-west-1"
  profile = "claranet-es-test"
}

terraform {
  backend "s3" {
  profile              = "claranet-es-test"
  bucket               = "igj-test-clara"
  key                  = "terraformmanagement/terraform.tfstate"
  region               = "eu-west-1"
  encrypt              = true
  }

  required_version = "= 1.3.3"

  required_providers {
    aws = {
      version = "~> 4.0.0"
      source  = "hashicorp/aws"
    }
  }
}
