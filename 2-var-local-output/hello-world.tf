# hello-world.tf
# terraform init
# terraform plan
# terraform apply -var-file="dev.tfvars" --auto-approve
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.9.0"
}

locals {
  tags = {
    Name = "hello-world-vpc-1",
    Team = "MyCloudAI"
  }
}

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.my_first_vpc.id
}


provider "aws" {
  region = var.aws_region
  # aws modle will use the default credentials from the environment or AWS CLI config, env name:
  # AWS_PROFILE
}

resource "aws_vpc" "my_first_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true 
  tags = local.tags
}