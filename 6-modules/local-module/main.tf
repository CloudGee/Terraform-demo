module "my_vpc" {

  source = "./modules/vpc"

  aws_vpc_cidr_block = var.aws_vpc_cidr_block

  aws_vpc_subnet_cidr_blocks = [
    cidrsubnet(var.aws_vpc_cidr_block, 8, 1),
    cidrsubnet(var.aws_vpc_cidr_block, 8, 2),
    cidrsubnet(var.aws_vpc_cidr_block, 8, 3),
    cidrsubnet(var.aws_vpc_cidr_block, 8, 4),
    cidrsubnet(var.aws_vpc_cidr_block, 8, 5),
  ]

}

output "vpc_id" {

  value = module.my_vpc.vpc_id

}

module "my_vpc_2" {

  source = "./modules/vpc"

  aws_vpc_cidr_block = "10.1.0.0/16"

}