resource "aws_vpc" "wp_vpc_eu" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "wp_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.wp_vpc_eu.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
#  map_customer_owned_ip_on_launch = true
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "wp-public-subnet-${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "wp_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.wp_vpc_eu.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
#  map_customer_owned_ip_on_launch = true
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "wp-private-subnet-${count.index + 1}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "wp_internet_gateway" {
  vpc_id = aws_vpc.wp_vpc_eu.id
  tags = {
    Name = "web_IGW"
  }
}


# Route Table
resource "aws_route_table" "wp_public_RT" {
  vpc_id = aws_vpc.wp_vpc_eu.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp_internet_gateway.id
  }

  tags = {
    Name = "wp_public_RT"
  }
}

resource "aws_route_table" "wp_private_RT" {
  vpc_id = aws_vpc.wp_vpc_eu.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp_internet_gateway.id
  }

  tags = {
    Name = "wp_private_RT"
  }
}

# Route Table Association
resource "aws_route_table_association" "wp_public_route_table_association" {
  count = length(aws_subnet.wp_public_subnets)
  subnet_id      = aws_subnet.wp_public_subnets[count.index].id
  route_table_id = aws_route_table.wp_public_RT.id
}

# Private Route Table Association
resource "aws_route_table_association" "wp_private_route_table_association" {
  count = length(aws_subnet.wp_private_subnets)
  subnet_id      = aws_subnet.wp_private_subnets[count.index].id
  route_table_id = aws_route_table.wp_private_RT.id
}

# Elastic IP resource
resource "aws_eip" "wp_eip" {
  # No need to specify any parameters, the default values will be used.
}


# NAT Gateway
resource "aws_nat_gateway" "wp_nat_public" {
  allocation_id = aws_eip.wp_eip.id
  subnet_id     = aws_subnet.wp_public_subnets[0].id

  tags = {
    Name = "wp-nat-gateway"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.wp_internet_gateway]
}