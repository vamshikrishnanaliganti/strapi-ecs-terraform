resource "aws_db_subnet_group" "strapi" {
  name       = "strapi-db-subnet-group-lav"
  subnet_ids = data.aws_subnets.default.ids
}

resource "aws_db_instance" "postgres" {
  identifier             = "strapi-postgres-lav"
  allocated_storage     = 20
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"

  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.strapi.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible   = false
  skip_final_snapshot   = true
  deletion_protection   = false
}