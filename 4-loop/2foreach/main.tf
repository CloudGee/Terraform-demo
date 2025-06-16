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

variable "vpc_map" {
  type = map(string)
  default = {
    dev_vpc = "192.168.100.0/24"
    prod_vpc = "10.0.0.0/16"
  }
}

resource "aws_vpc" "loop_vpc" {
  for_each = var.vpc_map
  cidr_block = each.value
  tags = {
    Name = each.key
  }
}

output "vpc_ids" {
  value = values(aws_vpc.loop_vpc)[*].id
}