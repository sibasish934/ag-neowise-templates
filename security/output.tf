output "public_sg_id"{
    description = "Public Security Group ID"
    value = aws_security_group.bastion-sg.id
}

output "private_sg_id"{
    description = "Private Security Group ID"
    value = aws_security_group.private-server.id
}

output "rds_sg_id" {
  description = "It is RDS security group id"
  value = aws_security_group.rds_sg.id
}