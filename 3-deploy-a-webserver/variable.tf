variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "aws_developer_vpc_cidr" {
  description = "The CIDR block for the developer VPC"
  type        = string
  default     = "192.168.100.0/24"
}

variable "additional_tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "env_prefix" {
  description = "Prefix for environment-specific resources"
  type        = string
  default     = "dev"
}