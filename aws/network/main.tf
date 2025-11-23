#vpc
resource "aws_vpc" "base" {
  cidr_block = var.network_info.cidr
  tags = {
    Name = var.network_info.name
    Env  = "dev"
  }
}

resource "aws_internet_gateway" "base" {
  count  = length(var.network_info.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = var.network_info.name
  }
}
resource "aws_route_table" "public" {
  count  = length(var.network_info.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.base.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.base[0].id
  }
  tags = {
    Name = "public"
  }
  depends_on = [aws_vpc.base]

}
resource "aws_subnet" "public_subnets" {
  count             = length(var.network_info.public_subnets)
  availability_zone = var.network_info.public_subnets[count.index].az
  cidr_block        = var.network_info.public_subnets[count.index].cidr
  vpc_id            = aws_vpc.base.id
  tags = {
    Name = var.network_info.public_subnets[count.index].name
  }
  depends_on = [aws_vpc.base]
}

resource "aws_route_table_association" "public" {
  count          = length(var.network_info.public_subnets)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public_subnets[count.index].id
  depends_on     = [aws_route_table.public, aws_subnet.public_subnets]
}


resource "aws_route_table" "private" {
  count  = length(var.network_info.private_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private"
  }
  depends_on = [aws_vpc.base]
}
resource "aws_subnet" "private_subnets" {
  count             = length(var.network_info.private_subnets)
  availability_zone = var.network_info.private_subnets[count.index].az
  cidr_block        = var.network_info.private_subnets[count.index].cidr
  vpc_id            = aws_vpc.base.id
  tags = {
    Name = var.network_info.private_subnets[count.index].name
  }
  depends_on = [aws_vpc.base]
}
resource "aws_route_table_association" "private" {
  count          = length(var.network_info.private_subnets)
  route_table_id = aws_route_table.private[0].id
  subnet_id      = aws_subnet.private_subnets[count.index].id
  depends_on     = [aws_route_table.private, aws_subnet.private_subnets]
}