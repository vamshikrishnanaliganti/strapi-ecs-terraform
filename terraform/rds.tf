resource "aws_db_subnet_group" "strapi" {
  name       = "strapi-db-subnet-group"
  subnet_ids = data.aws_subnets.default.ids
}

resource "aws_db_instance" "postgres" {
  identifier             = "strapi-postgres"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14.6"
  instance_class         = "db.t3.micro"

  db_name  = var.db_name
  username = "strapiadmin"
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.strapi.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true
}
