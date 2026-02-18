output "ecs_cluster_name" {
  value = aws_ecs_task_definition.strapi.family
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}
output "ecs_image" {
  value = "${var.ecr_repo_url}:${var.image_tag}"
}