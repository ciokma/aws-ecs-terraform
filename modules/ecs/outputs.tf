output "cluster_id" {
  description = "ECS cluster ID."
  value       = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  description = "ECS cluster ARN."
  value       = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  description = "ECS cluster name."
  value       = aws_ecs_cluster.this.name
}

output "task_definition_arn" {
  description = "ECS Task Definition ARN."
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "ECS Task Definition family."
  value       = aws_ecs_task_definition.this.family
}

output "security_group_id" {
  description = "ECS Security Group ID."
  value       = aws_security_group.ecs.id
}

output "log_group_name" {
  description = "CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.name
}
output "service_name" {
  description = "ECS service name."
  value       = aws_ecs_service.this.name
}