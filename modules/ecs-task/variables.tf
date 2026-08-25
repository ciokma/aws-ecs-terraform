variable "name" {
  description = "Base name for ECS resources."
  type        = string
}
variable "vpc_id" {
  description = "VPC ID."
  type        = string
}
variable "subnet_ids" {
  description = "Subnet IDs where ECS Fargate tasks will run."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 1
    error_message = "At least one subnet ID must be provided."
  }
}

variable "desired_count" {
  description = "Number of ECS tasks to run."
  type        = number

  validation {
    condition     = var.desired_count >= 1
    error_message = "desired_count must be at least 1."
  }
}
variable "execution_role_arn" {
  description = "ECS Task Execution Role ARN."
  type        = string
}

variable "task_role_arn" {
  description = "ECS Task Role ARN."
  type        = string
}

variable "container_name" {
  description = "Container name."
  type        = string
  default     = "app"
}

variable "container_image" {
  description = "Container image."
  type        = string
}

variable "container_port" {
  description = "Container port."
  type        = number
  default     = 8080
}

variable "cpu" {
  description = "Task CPU units."
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task memory in MB."
  type        = number
  default     = 512
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}


variable "environment" {
  description = "Environment variables passed to the ECS container"

  type = list(object({
    name  = string
    value = string
  }))

  default = []
}

variable "aws_ecs_cluster" {
  description = "ECS Cluster to deploy the service."
  type        = any
}