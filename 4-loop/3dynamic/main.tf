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

variable "ingress_rules" {
  type = list(object({
    protocol = string
    from_port = number
    to_port = number
    cidr_blocks = list(string)
  }))
  default = [
    {
      protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      protocol = "tcp"
      from_port = 443
      to_port = 443
      cidr_blocks = ["0.0.0.0/0"]
    }]
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.test_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    iterator = ingress
    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  tags = {
    Name = "web_sg"
  }
}