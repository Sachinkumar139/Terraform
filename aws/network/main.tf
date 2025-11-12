resource "aws_vpc" "base" {
  cidr_block = var.network_info.cidr
  tags = {
    Name = var.network_info.name
    Env  = "dev"
  }


}
# app1 subnet
resource "aws_subnet" "app1" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.subnet1_info.az
  cidr_block        = var.subnet1_info.cidr

  tags = {
    Name = var.subnet1_info.name
  }
  depends_on = [aws_vpc.base]


}
# subnet2
resource "aws_subnet" "app2" {
  vpc_id            = aws_vpc.base.id
  availability_zone = "ap-south-1a"
  cidr_block        = var.subnet2_info.cidr

  tags = {
    Name = var.subnet2_info.name
  }
  depends_on = [aws_vpc.base]
}

#subnet-3
resource "aws_subnet" "app3" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.subnet3_info.az
  cidr_block        = var.subnet3_info.cidr
  tags = {
    Name = var.subnet3_info.name
  }
  depends_on = [aws_vpc.base]
}
#subnet 4
resource "aws_subnet" "app4" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.subnet4_info.az
  cidr_block        = var.subnet4_info.cidr
  tags = {
    Name = var.subnet4_info.name
  }
  depends_on = [aws_vpc.base]
}
# instance ubuntu 
resource "aws_instance" "ubuntu" {
  ami                         = "ami-0078a63645c7b8a87"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.app2.id
  associate_public_ip_address = true
  tags = {
    Name = "ubuntu"
  }

}

#Security groups
