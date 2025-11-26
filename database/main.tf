resource "random_password" "rds_password"{
    length = 16
    special = false
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "${var.prefix}-rds-password"
}

resource "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = aws_secretsmanager_secret.rds_password.id
  secret_string = jsonencode({password = random_password.rds_password.result})
}

resource "aws_db_instance" "postgres" {
  identifier = "${var.prefix}-postgres"
  engine = "postgres"
  engine_version = "18.1"
  instance_class = "db.t3.micro"
  allocated_storage = 30
  username = "dbadmin"
  password = random_password.rds_password.result
  vpc_security_group_ids = [ var.rds_sg_id ]
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot = true

  tags = merge(
    var.common_tags,
    tomap(
    {
      "Name" = "${var.prefix}-postgres"
    })
  )

}

resource "aws_db_subnet_group" "main" {
  name = "${var.prefix}-db-subnet-group"
  subnet_ids = length(var.private_subnet_ids) > 0 ? var.private_subnet_ids : [ var.private_subnet_id ]

  tags = merge(
    var.common_tags,
    tomap({
      Name = "${var.prefix}-db-subnet-group"
    })
  )
}