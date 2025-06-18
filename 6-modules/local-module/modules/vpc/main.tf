locals {
  tags = try(var.tags, {})
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.aws_vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = local.tags
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "my_subnet" {
  count = try(length(var.aws_vpc_subnet_cidr_blocks), 0)

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.aws_vpc_subnet_cidr_blocks[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = local.tags

}

resource "aws_internet_gateway" "my_igw" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.my_vpc.id

  tags = local.tags
}