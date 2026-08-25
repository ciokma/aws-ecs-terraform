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
  source     = "../../modules/ecs"
  name       = local.name
  aws_region = var.aws_region
  tags       = local.tags
}
# =========================================================
# ECS - Frontend
# =========================================================
module "frontend_ecs" {
  source = "../../modules/ecs-task"

  name = "gimnasio-frontend"

  aws_region      = var.aws_region
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  aws_ecs_cluster = module.ecs.cluster_id

  container_name  = "gimnasio-frontend"
  container_image = "${module.ecr_frontend.repository_url}:latest"
  container_port  = var.container_port

  cpu    = var.ecs_cpu
  memory = var.ecs_memory

  desired_count = var.desired_count

  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  environment = var.environment_vars_frontend

  log_retention_days = 7

  tags = local.tags

}

# =========================================================
# ECS - Backend API
# =========================================================

module "backend_ecs" {
  source = "../../modules/ecs-task"

  name = "gimnasio-api"

  aws_region      = var.aws_region
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  aws_ecs_cluster = module.ecs.cluster_id

  container_name  = "gimnasio-api"
  container_image = "${module.ecr_backend.repository_url}:latest"
  container_port  = var.container_port

  cpu    = var.ecs_cpu_backend
  memory = var.ecs_memory_backend

  desired_count = var.desired_count


  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  environment = var.environment_vars_backend

  log_retention_days = 7

  tags = local.tags
}

# module "database_secret" {
#   source = "../../modules/secrets-manager"

#   name        = "${local.name}/database"
#   description = "Database credentials for ${local.name}"

#   tags = local.tags
# }
# module "rds_mysql" {
#   source = "../../modules/rds-mysql"

#   name = "${local.name}-mysql"

#   vpc_id = module.vpc.vpc_id

#   subnet_ids = module.vpc.public_subnet_ids

#   allowed_security_group_ids = [
#     module.backend_ecs.security_group_id
#   ]

#   db_name          = var.db_name
#   db_username      = var.db_username
#   db_password      = var.db_password

#   instance_class = var.db_instance_class

#   multi_az = var.multi_az

#   tags = local.tags
#   publicly_accessible = var.publicly_accessible
# }
