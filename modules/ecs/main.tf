# =========================================================
# ECS Cluster
# =========================================================

resource "aws_ecs_cluster" "this" {
  name = "${var.name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
  region = var.aws_region
}


