data "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

}
data "aws_subnets" "other" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.main.id]
    }  
}

output "other-id" {
    value = data.aws_vpc.main.id 
}

output "subnet-ids" {
    value = data.aws_subnets.other.ids
  
}