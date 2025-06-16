variable "server_names" {
  type = list(string)
  default = ["web", "app", "db"]
}

locals {
  # 创建完整的服务器名称列表
  full_server_names = [for name in var.server_names : "${name}-server"]

  # 创建大写的服务器名称
  upper_server_names = [for name in var.server_names : upper(name)]

  # 条件过滤
  web_servers = [for name in var.server_names : name if length(name) < 4]
}

output "values" {
  value = {
    full_server_names = local.full_server_names
    upper_server_names = local.upper_server_names
    web_servers = local.web_servers
  }
  description = "List of server names with transformations and conditions"
}

variable "environments" {
  type = map(object({
    instance_count = number
    instance_type  = string
  }))
  default = {
    dev  = { instance_count = 1, instance_type = "t2.micro" }
    prod = { instance_count = 3, instance_type = "t2.small" }
  }
}

locals {
  # 创建环境到实例类型的映射
  env_instance_types = {
    for env, config in var.environments : env => config.instance_type
  }

  # 创建需要多实例的环境列表
  multi_instance_envs = [
    for env, config in var.environments : env if config.instance_count > 1
  ]

  # 创建扁平化的实例配置
  instance_configs = flatten([
    for env, config in var.environments : [
      for i in range(config.instance_count) : {
        name = "${env}-${i}"
        type = config.instance_type
        env  = env
      }
    ]
  ])
}

output "values_2" {
  value = {
    env_instance_types = local.env_instance_types
    multi_instance_envs = local.multi_instance_envs
    instance_configs = local.instance_configs
  }
  description = "Environment to instance type mapping, multi-instance environments, and flattened instance configurations"

}