# Private ec2
resource "aws_instance" "private" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  availability_zone      = "ap-south-1a"
  vpc_security_group_ids = [ var.private_sg_id ]
  key_name               = var.ssh_key_name
  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-private-ec2" })
  )
}

# Public ec2
resource "aws_instance" "public" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [ var.public_sg_id ]
  key_name               = var.ssh_key_name
  availability_zone      = "ap-south-1a"

  tags = merge(
    var.common_tags,
    tomap({ "Name" = "${var.prefix}-public-ec2" })
  )
}