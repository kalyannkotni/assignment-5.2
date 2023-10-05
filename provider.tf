# Terraform Block
terraform {
  required_providers {
    aws = { 
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "assignment-5.2-aws-cicd-pipeline"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}

# Provider Block
provider "aws" {
  region = "${var.aws-region}"
}

