resource "aws_security_group" "mq_sg" {
  name        = "${var.name}-mq-sg"
  description = "Allow MQ traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow broker traffic"
    from_port   = 61617
    to_port     = 61617
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_mq_broker" "mq_broker" {
  broker_name        = var.name
  engine_type        = var.engine_type
  engine_version     = var.engine_version
  host_instance_type = var.instance_type
  deployment_mode    = var.deployment_mode
  subnet_ids         = var.subnet_ids
  security_groups    = [aws_security_group.mq_sg.id]
  publicly_accessible = var.publicly_accessible

  user {
    username = var.username
    password = var.password
  }

  tags = var.tags
}
