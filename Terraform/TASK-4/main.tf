resource "aws_vpc" "exist" {

    tags = {
      Name = "ivolve-20"
       
    }
  
}
resource "aws_subnet" "Public_1" {
  vpc_id = aws_vpc.exist.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public-sub-TASK-final"
  }
}

resource "aws_subnet" "Private_2" {
  vpc_id = aws_vpc.exist.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-subnet-TASK-FINAL"
  }
  
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.exist.id
  tags = {
    Name = "Internet_gateway"
  }
  
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "NAT GATEWAY_EIP"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.Public_1.id
  tags = {
    Name = " NAT GATEWAY "
  }
}
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.exist.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public-task-final"
  }
}
resource "aws_route_table_association" "public_subnet_assoicate" {
  subnet_id = aws_subnet.Public_1.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table" "private_route_table" {
 vpc_id = aws_vpc.exist.id

 route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
  
 }
 tags ={
  Name = "private-route-table-Final"
 }  
}
resource "aws_route_table_association" "Private_assoc" {
  subnet_id = aws_subnet.Private_2.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.exist.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public SG"
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.exist.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.Public_1.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private SG"
  }
}



# EC2 Instances
resource "aws_instance" "nginx_server" {
  ami           = "ami-005fc0f236362e99f" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.Public_1.id
  security_groups = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "Nginx server ivolve completed!" >> /var/log/setup.log
  EOF

  tags = {
    Name = "Nginx Server"
  }
}

resource "aws_instance" "apache_server" {
  ami           = "ami-005fc0f236362e99f" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.Private_2.id
  security_groups = [aws_security_group.private_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
     echo "apache2 server ivolve" >> /var/log/setup.log
  EOF

  tags = {
    Name = "Apache Server"
  }
}
