output "vpc_id" {
  description = "The is id of the vpc"
  value = aws_vpc.main.id
}

output "private_subnet_id"{
    description = "The id of the private subnet"
    value = aws_subnet.private.id
}

output "public_subnet_id" {
  description = "The id of the public subnet"
  value = aws_subnet.public.id
}
