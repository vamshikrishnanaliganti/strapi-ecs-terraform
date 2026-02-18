

resource "aws_db_subnet_group" "strapi" {
  name        = "strapi-subnet-group"
  subnet_ids  = data.aws_subnets.default.ids
  description = "Subnet group for Strapi RDS"
}

# resource "aws_db_instance" "postgres" {
#    identifier         = var.db_name 
#   engine             = "postgres"
#   engine_version     = "15.3"
#   instance_class     = "db.t3.micro"
#   allocated_storage  = 20
# #   name               = var.db_name
#   username           = var.db_username
#   password           = random_password.db_password.result
#   db_subnet_group_name = aws_db_subnet_group.strapi.name
#   publicly_accessible = true
#   skip_final_snapshot = true
# }
resource "aws_db_instance" "postgres" {
  identifier          = var.db_name
  engine              = "postgres"
  engine_version      = "15"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = var.db_username
  password            = random_password.db_password.result
  db_subnet_group_name = aws_db_subnet_group.strapi.name
  publicly_accessible  = true
  skip_final_snapshot  = true
}
