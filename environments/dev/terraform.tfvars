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

ecr_max_image_count = 5

# =========================================================
# ECS
# =========================================================

container_name  = "gimnasio-api"
container_image = "public.ecr.aws/docker/library/nginx:latest"

container_port = 80

ecs_cpu    = 256
ecs_memory = 512

desired_count = 1