resource "aws_vpc" "ivolve-vpc-terr" {
  cidr_block = var.cidr_block 
  tags = {
    Name ="vpc-module-task-1"
  }
}

resource "aws_subnet" "Public_task2" {
  for_each = var.mult_pub_sub
  vpc_id     = aws_vpc.ivolve-vpc-terr.id
  cidr_block = each.value
  availability_zone = each.key 
  map_public_ip_on_launch = true 
  tags = {
    Name = "Public-mod-task-${each.value}"
  }
} 
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.ivolve-vpc-terr.id
    tags = {
      Name = "igw-4-ivolve-module"
    } 
}
resource "aws_route_table" "PublicRT-module" {
    vpc_id = aws_vpc.ivolve-vpc-terr.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "Public-ivolve-RT-module"
    } 
} 
resource "aws_route_table_association" "Assoic" { 
    
    for_each = aws_subnet.Public_task2 
    subnet_id = each.value.id
    route_table_id = aws_route_table.PublicRT-module.id 
}