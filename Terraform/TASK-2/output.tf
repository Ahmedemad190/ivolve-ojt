data "aws_vpc" "ivolve" {
  filter {
    name   = "tag:Name" #filter by vpc_name
    values = ["ivolve-vpc"]  
  }
}
# Output to verify the VPC ID
output "ivolve_vpc_id" {
  value = data.aws_vpc.ivolve.id
}
