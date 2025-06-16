locals {
  tags = merge(
    {
      Team = "MyCloudAI"
    },
    var.additional_tags
  )
}