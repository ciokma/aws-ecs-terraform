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

variable "desired_count" {
  description = "Number of ECS tasks."
  type        = number
}
variable "react_app_api_url" {
  type        = string
  description = "Backend API URL for the React application"
}

variable "react_app_target" {
  type        = string
  description = "React application target"
}

variable "react_app_image_url" {
  type        = string
  description = "Backend image URL for React images"
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

variable "ecr_max_image_count" {
  description = "Maximum number of images retained in ECR"
  type        = number
  default     = 10
}