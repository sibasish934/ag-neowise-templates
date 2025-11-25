resource "aws_security_group" "private-server" {
  description = "EC2 server security group"
  name        = "${var.prefix}-server-${var.env}-sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 3000
    to_port     = 3000
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = [var.vpc_cidr]
  }

  tags = var.common_tags
}


resource "aws_security_group" "bastion-sg"{
    description = "EC2 server security group"
    name = "${var.prefix}-bastion-server-${var.env}-sg"
    vpc_id = var.vpc_id

    ingress {
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = var.common_tags
}

resource "aws_security_group" "rds_sg"{
    description = "RDS security group"
    name = "${var.prefix}-rds-${var.env}-sg"
    vpc_id = var.vpc_id
    ingress {
        protocol = "tcp"
        from_port = 5432
        to_port = 5432
        cidr_blocks = [var.vpc_cidr]
    }

    egress {
        from_port= 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(var.common_tags, tomap({Name = "${var.prefix}-rds-${var.env}-sg"}))
}