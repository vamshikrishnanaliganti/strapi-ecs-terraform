resource "aws_ecs_cluster" "this" {
  name = "strapi-cluster-lav"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = "arn:aws:iam::138383657644:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
  {
    name      = "strapi"
    image = "${var.ecr_repo_url}:${var.image_tag}"
    essential = true

    portMappings = [
      {
        containerPort = 1337
        protocol      = "tcp"
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/strapi"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }

    environment = [
      { name = "NODE_ENV", value = "production" },

      { name = "APP_KEYS", value = "aVeryLongRandomKey1,aVeryLongRandomKey2,aVeryLongRandomKey3,aVeryLongRandomKey4" },
      { name = "API_TOKEN_SALT", value = "aVeryLongRandomSaltString1234567890" },
      { name = "ADMIN_JWT_SECRET", value = "aVeryLongAdminJwtSecret1234567890" },
      { name = "JWT_SECRET", value = "aVeryLongJwtSecret1234567890" },

      { name = "DATABASE_CLIENT",   value = "postgres" },
      { name = "DATABASE_HOST",     value = aws_db_instance.postgres.address },
      { name = "DATABASE_PORT",     value = "5432" },
      { name = "DATABASE_NAME",     value = var.db_name },
      { name = "DATABASE_USERNAME", value = var.db_username },
      { name = "DATABASE_PASSWORD", value = var.db_password },
      { name = "DATABASE_SSL",      value = "false" }
    ]
  }
])

}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_db_instance.postgres]
}