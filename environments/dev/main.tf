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


module "ecr_frontend" {
  source = "../../modules/ecr"

  repository_name      = var.ecr_frontend_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  max_image_count      = var.ecr_max_image_count

  tags = merge(
    local.tags,
    {
      Application = "gimnasio-web-frontend"
      Component   = "frontend"
    }
  )
}

module "ecr_backend" {
  source = "../../modules/ecr"

  repository_name      = var.ecr_backend_repository_name
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  max_image_count      = var.ecr_max_image_count

  tags = merge(
    local.tags,
    {
      Application = "gimnasio-web-api"
      Component   = "backend"
    }
  )
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

  # React runtime environment variables
  react_app_api_url   = var.react_app_api_url
  react_app_target    = var.react_app_target
  react_app_image_url = var.react_app_image_url
  
  tags = local.tags
}
