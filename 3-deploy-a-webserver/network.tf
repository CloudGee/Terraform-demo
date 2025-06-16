resource "aws_vpc" "developer_vpc" {
  cidr_block = var.aws_developer_vpc_cidr
  tags = merge(
    {
      Name = "${var.env_prefix}-vpc"
    },
    local.tags
  )
}

resource "aws_subnet" "developer_subnet" {
  vpc_id            = aws_vpc.developer_vpc.id
  cidr_block        = "${var.aws_developer_vpc_cidr}"
  availability_zone = "${var.aws_region}a"
  tags = merge(
    {
      Name = "${var.env_prefix}-subnet"
    },
    local.tags
  )
}

resource "aws_internet_gateway" "developer_igw" {
  vpc_id = aws_vpc.developer_vpc.id
  tags = merge(
    {
      Name = "${var.env_prefix}-igw"
    },
    local.tags
  )
}

resource "aws_route_table" "developer_route_table" {
  vpc_id = aws_vpc.developer_vpc.id
  tags = merge(
    {
      Name = "${var.env_prefix}-route-table"
    },
    local.tags
  )
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.developer_igw.id
  }
}

resource "aws_route_table_association" "developer_route_table_association" {
  subnet_id      = aws_subnet.developer_subnet.id
  route_table_id = aws_route_table.developer_route_table.id
}

resource "aws_security_group" "developer_sg" {
  name        = "${var.env_prefix}-sg"
  description = "Security group for developer resources"
  vpc_id      = aws_vpc.developer_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    {
      Name = "${var.env_prefix}-sg"
    },
    local.tags
  )

  lifecycle {
    create_before_destroy = false
  }
}