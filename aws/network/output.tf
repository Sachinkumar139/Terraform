output "vpc_id" {
    value =  aws_vpc.base.id
  
}

output "private_subnets_ids" {
    value = aws_subnet.private_subnets[*].id
}

output "public_ids" {
    value = aws_subnet.public_subnets[*].id
  
}