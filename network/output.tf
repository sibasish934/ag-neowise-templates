output "vpc_id" {
  description = "The is id of the vpc"
  value = aws_vpc.main.id
}

output "private_subnet_id"{
    description = "The id of the private subnet"
    value = aws_subnet.private[0].id
}

output "public_subnet_id" {
  description = "The id of the public subnet"
  value = aws_subnet.public[0].id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value = aws_subnet.private[*].id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value = aws_subnet.public[*].id
}
