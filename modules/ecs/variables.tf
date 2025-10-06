variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Enable or disable container insights (enabled/disabled)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ECS cluster"
  type        = map(string)
}
