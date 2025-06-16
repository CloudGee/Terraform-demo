terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "loop_vpc" {
  count = 3
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "loop-vpc-${count.index}"
  }
}

output "vpc_ids" {
  value = aws_vpc.loop_vpc[*].id
}