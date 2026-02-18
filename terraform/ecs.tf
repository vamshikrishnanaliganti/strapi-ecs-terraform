resource "aws_ecs_cluster" "main" {
  name = "strapi-cluster"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name      = "strapi"
    image     = "${aws_ecr_repository.strapi.repository_url}:${var.image_tag}"
    essential = true
    portMappings = [{
      containerPort = 1337
      hostPort      = 1337
    }]
    environment = [
      {
        name  = "DATABASE_CLIENT"
        value = "postgres"
      },
      {
        name  = "DATABASE_HOST"
        value = aws_db_instance.postgres.address
      },
      {
        name  = "DATABASE_PORT"
        value = "5432"
      },
      {
        name  = "DATABASE_NAME"
        value = var.db_name
      },
      {
        name  = "DATABASE_USERNAME"
        value = var.db_username
      },
      {
        name  = "DATABASE_PASSWORD"
        value = random_password.db_password.result
      }
    ]
  }])
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}
