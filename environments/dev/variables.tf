variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

# ---------------------------------------------------------
# VPC
# ---------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the environment."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two availability zones are required."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "The number of public subnets must match the number of availability zones."
  }
}

# ---------------------------------------------------------
# ECR
# ---------------------------------------------------------

variable "ecr_max_image_count" {
  description = "Maximum number of container images retained in ECR."
  type        = number
}

# ---------------------------------------------------------
# ECS
# ---------------------------------------------------------

variable "container_name" {
  description = "ECS container name."
  type        = string
}

variable "container_image" {
  description = "Initial container image."
  type        = string
}

variable "container_port" {
  description = "Container application port."
  type        = number
}

variable "ecs_cpu" {
  description = "ECS Fargate CPU units."
  type        = number
}

variable "ecs_memory" {
  description = "ECS Fargate memory in MB."
  type        = number
}
variable "ecs_cpu_backend" {
  description = "ECS Fargate CPU units for the backend."
  type        = number
}

variable "ecs_memory_backend" {
  description = "ECS Fargate memory in MB for the backend."
  type        = number
}
variable "desired_count" {
  description = "Number of ECS tasks."
  type        = number
}

variable "ecr_frontend_repository_name" {
  description = "ECR repository name for the frontend"
  type        = string
}

variable "ecr_backend_repository_name" {
  description = "ECR repository name for the backend API"
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable ECR image scanning on push"
  type        = bool
  default     = true
}

variable "environment_vars_frontend" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
variable "environment_vars_backend" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}


variable "backup_retention_period" {
  description = "Backup retention in days"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying"
  type        = bool
  default     = true
}
variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}
variable multi_az {
  description = "Enable Multi-AZ deployment for RDS"
  type        = bool
  default     = false
}