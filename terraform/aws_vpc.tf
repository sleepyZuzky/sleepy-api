resource "aws_vpc" "sleepy_network" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc-${local.entity}-${local.environment}"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.sleepy_network.id
  for_each                = local.pub_subnets_cidr
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-net-${each.key}"
  }

  depends_on = [aws_vpc.sleepy_network]
}

resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.sleepy_network.id
  for_each                = local.priv_subnets_cidr
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false

  tags = {
    Name = "priv-net-${each.key}"
  }

  depends_on = [aws_vpc.sleepy_network]
}

resource "aws_db_subnet_group" "private_group" {
  name = "private-main"
  subnet_ids = [aws_subnet.private_subnets["${local.region}a"].id, aws_subnet.private_subnets["${local.region}b"].id]

  tags = {
    Name = "Db Subnet Group"
  }

  depends_on = [aws_subnet.private_subnets]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.sleepy_network.id

  tags = {
    Name = "gs-${local.entity}-${local.environment}"
  }

  depends_on = [aws_vpc.sleepy_network]
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.sleepy_network.id

  route {
    cidr_block = var.routing_table_cird_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-${local.entity}-${local.environment}"
  }

  depends_on = [aws_vpc.sleepy_network]
}

resource "aws_route_table_association" "public-rt-subnets" {
  route_table_id = aws_route_table.rt.id

  for_each = aws_subnet.public_subnets
  subnet_id = each.value.id

  depends_on = [aws_subnet.public_subnets, aws_route_table.rt]
}
