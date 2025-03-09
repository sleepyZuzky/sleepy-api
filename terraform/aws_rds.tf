resource "aws_db_instance" "sleepy_db" {
  allocated_storage = 20
  db_name = local.database.name
  engine = "postgres"
  engine_version = "14.17"
  instance_class = "db.t4g.micro"
  username = local.database.username
  password = local.database.password
  parameter_group_name = "default.postgres14"
  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.private_group.name

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

  depends_on = [aws_db_subnet_group.private_group]
}
