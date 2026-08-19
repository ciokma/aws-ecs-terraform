output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "ecr_repository_name" {
  description = "ECR repository name."
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN."
  value       = module.ecs.cluster_arn
}

output "ecs_service_name" {
  description = "ECS service name."
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ECS task definition ARN."
  value       = module.ecs.task_definition_arn
}

output "ecs_security_group_id" {
  description = "ECS security group ID."
  value       = module.ecs.security_group_id
}

output "ecs_execution_role_arn" {
  description = "ECS execution role ARN."
  value       = module.iam.ecs_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ECS task role ARN."
  value       = module.iam.ecs_task_role_arn
}