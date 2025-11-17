resource "aws_vpc" "base" {
  cidr_block = var.network_info.cidr
  tags = {
    Name = var.network_info.name
    Env  = "dev"
  }
}


resource "aws_subnet" "subnets" {
  count             = length(var.network_info.subnets)
  availability_zone = var.network_info.subnets[count.index].az
  cidr_block        = var.network_info.subnets[count.index].cidr
  vpc_id            = aws_vpc.base.id
  tags = {
    Name = var.network_info.subnets[count.index].name
  }
  depends_on = [aws_vpc.base]
}