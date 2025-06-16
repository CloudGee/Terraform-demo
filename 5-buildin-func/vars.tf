variable "cpu_requests" {
  default = [2, 4, 1, 8]
}

variable "environment" {
  default = "PRODUCTION"
}

variable "app_name" {
  default = "my-web-app"
}

variable "common_tags" {
  default = {
    Project = "web-platform"
    Owner   = "devops-team"
  }
}

variable "env_tags" {
  default = {
    Environment = "staging"
    CostCenter  = "engineering"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}