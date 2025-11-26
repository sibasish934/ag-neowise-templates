resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-vpc-${var.environment}"
    })
  )
}

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_list[count.index]
  availability_zone = count.index == 0 ? "ap-south-1a" : "ap-south-1b"
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    tomap({
      Name = "${var.prefix}-public-subnet-${count.index + 1}-${var.environment}"
    })
  )
}

resource "aws_subnet" "private"{
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_list[count.index + 2]
  availability_zone = count.index == 0 ? "ap-south-1a" : "ap-south-1b"
  tags = merge(
    var.common_tags,
    tomap({
      Name = "${var.prefix}-private-subnet-${count.index + 1}-${var.environment}"
    })
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-igw-${var.environment}"
    })
  )
}

resource "aws_eip" "public"{
  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-eip-${var.environment}"
    })
  )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.public.id
  subnet_id = aws_subnet.public[0].id

  tags = merge(
    var.common_tags,
    tomap({
      Name = "${var.prefix}-nat-${var.environment}"
    })
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-public-route-${var.environment}"
    })
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-private-route-${var.environment}"
    })
  )
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}