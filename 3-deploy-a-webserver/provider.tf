terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "aws" {
  region = var.aws_region
}