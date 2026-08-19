locals {
  name = "${var.project_name}-${var.environment}"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# =========================================================
# VPC
# =========================================================

module "vpc" {
  source = "../../modules/vpc"

  name = local.name

  vpc_cidr = var.vpc_cidr

  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs

  tags = local.tags
}

# =========================================================
# ECR
# =========================================================

module "ecr" {
  source = "../../modules/ecr"

  repository_name = "${local.name}-app"

  scan_on_push    = true
  max_image_count = var.ecr_max_image_count

  tags = local.tags
}

# =========================================================
# IAM
# =========================================================

module "iam" {
  source = "../../modules/iam"

  name = local.name

  tags = local.tags
}

# =========================================================
# ECS
# =========================================================

module "ecs" {
  source = "../../modules/ecs"

  name = local.name

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.public_subnet_ids

  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  container_name  = var.container_name
  container_image = var.container_image
  container_port  = var.container_port

  cpu    = var.ecs_cpu
  memory = var.ecs_memory

  desired_count = var.desired_count

  aws_region = var.aws_region

  tags = local.tags
}
