output "vpc_id_value" {
    value = aws_vpc.ivolve-vpc-terr
}
output "public_ids" {
  value = values(aws_subnet.Public_task2)[*].id 
}