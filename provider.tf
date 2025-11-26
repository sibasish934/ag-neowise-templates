terraform {
  #required_version = ">=1.5.7"
  required_providers {
    aws = {
       source = "hashicorp/aws"
       version = ">=6.20.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }

  # backend "s3" {
  #  path = "./terraform.tfstate"
  # }

      backend "s3" {
      bucket         = "my-backend-devops1 -1-terraform"
      key            = "tfstate/terraform.tfstate"
      region         = "ap-south-1"
      encrypt        = true
      dynamodb_table = "terraform-lock-table"
   }
}

provider "aws" {
  region = var.region
}
