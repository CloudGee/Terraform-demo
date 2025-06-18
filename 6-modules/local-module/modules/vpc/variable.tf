variable "aws_vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "create_igw" {
  description = "Whether to create an Internet Gateway"
  type        = bool
  default     = true
}

variable "aws_vpc_subnet_cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  default = []
}

variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default = {}
}