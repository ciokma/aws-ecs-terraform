output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN."
  value       = module.ecs.cluster_arn
}

output "ecs_frontend_service_name" {
  description = "ECS Frontend service name."
  value       = module.frontend_ecs.service_name
}
output "ecs_backend_service_name" {
  description = "ECS Backend service name."
  value       = module.backend_ecs.service_name
}


output "ecs_execution_role_arn" {
  description = "ECS execution role ARN."
  value       = module.iam.ecs_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ECS task role ARN."
  value       = module.iam.ecs_task_role_arn
}
output "ecr_frontend_repository_url" {
  value = module.ecr_frontend.repository_url
}

output "ecr_backend_repository_url" {
  value = module.ecr_backend.repository_url
}