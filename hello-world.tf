terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# 使用环境变量作为变量输入
variable "access_key" {
  description = "AWS Access Key"
  default = "$ENV{AWS_ACCESS_KEY_ID}"
}
 
variable "secret_key" {
  description = "AWS Secret Key"
  default = "$ENV{AWS_SECRET_ACCESS_KEY}"
}


provider "aws" {
  region = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "aws" {
  cidr_block = "10.0.0/16"
  enable_dns_hostnames = true 
  tags = {
    Name = "hello-world-vpc"
  }
}