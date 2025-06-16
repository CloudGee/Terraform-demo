# hello-world.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "us-west-2"
  # aws modle will use the default credentials from the environment or AWS CLI config, env name:
  # AWS_PROFILE
}

resource "aws_vpc" "my_first_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true 
  tags = {
    Name = "hello-world-vpc-1"
  }
}