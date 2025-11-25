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
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_list[0]
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-public-subnet-${var.environment}"
    })
  )
}

resource "aws_subnet" "private"{
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_list[1]
  availability_zone = "ap-south-1a"
  tags = merge( 
    var.common_tags,
    tomap({
      Name = "${var.prefix}-public-subnet-${var.environment}"
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
  subnet_id = aws_subnet.public.id

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
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}