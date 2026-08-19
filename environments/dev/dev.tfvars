aws_region   = "us-east-1"
project_name = "gimnasio"
environment  = "dev"

# =========================================================
# VPC
# =========================================================

vpc_cidr = "10.10.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]

# =========================================================
# ECR
# =========================================================

ecr_frontend_repository_name = "gimnasio-web-frontend"
ecr_backend_repository_name  = "gimnasio-web-api"

ecr_image_tag_mutability = "MUTABLE"
ecr_scan_on_push         = true
ecr_max_image_count      = 5

# =========================================================
# ECS
# =========================================================

container_name  = "gimnasio-api"
container_image = "784590287404.dkr.ecr.us-east-1.amazonaws.com/gimnasio-api-app:latest"

container_port = 80

ecs_cpu    = 256
ecs_memory = 512

desired_count = 1

react_app_api_url   = "http://localhost:5211/api"
react_app_target    = "FRONTEND"
react_app_image_url = "http://localhost:5211/images"

