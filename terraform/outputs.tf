output "ecs_cluster_name" {
  value = module.ecs_cluster.ecs_cluster_name
}

output "ecs_cluster_arn" {
  value = module.ecs_cluster.ecs_cluster_arn
}
# -------------------------------------------------------
# ECR Outputs
# -------------------------------------------------------

output "ecr_repository_name" {
  description = "The name of the ECR repository"
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository (used for pushing Docker images)"
  value       = module.ecr.repository_url
}

output "ecr_repository_arn" {
  description = "The Amazon Resource Name (ARN) of the ECR repository"
  value       = module.ecr.repository_arn
}

output "ecr_registry_id" {
  description = "The AWS account ID (registry ID) associated with the ECR repository"
  value       = module.ecr.registry_id
}

output "security_group_id" {
  description = "The ID of the created Security Group"
  value       = module.security_group.security_group_id
}

output "security_group_name" {
  description = "The name of the Security Group"
  value       = module.security_group.security_group_name
}

output "security_group_arn" {
  description = "The ARN of the Security Group"
  value       = module.security_group.security_group_arn
}

