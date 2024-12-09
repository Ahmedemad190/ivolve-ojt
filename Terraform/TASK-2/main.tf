resource "aws_subnet" "Public_subnet_ivolve" {
    vpc_id = data.aws_vpc.ivolve.id
    cidr_block = var.Pub_cidr_block
    availability_zone = var.a_z
    map_public_ip_on_launch = true
    tags = {
      Name = "Public_subnet-ivolve"
    }
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           =   "ami-005fc0f236362e99f"                           #data.aws_ami.ubuntu.id
instance_type = "t3.micro"
subnet_id = aws_subnet.Public_subnet_ivolve.id
security_groups = [ aws_security_group.web_SG.id ]
 provisioner "local-exec" {
  command = "echo ${self.public_ip} >> public_ips_2.txt"
   
 }
tags = {
Name = "terraform-task1-ivolve"
  }
}
resource "aws_subnet" "private_subnet_ivl" {
  for_each = var.mult_priv_sub
  vpc_id = data.aws_vpc.ivolve.id
  cidr_block = each.value 
  availability_zone = each.key 
  map_public_ip_on_launch = false 
  tags = {
    Name = "private_sub-${each.value}"
  }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = data.aws_vpc.ivolve.id
    tags = {
      Name = "igw-4-ivolve"
    } 
}

resource "aws_route_table" "PublicRT" {
    vpc_id = data.aws_vpc.ivolve.id
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "Public-ivolve-RT"
    } 
} 
resource "aws_route_table_association" "Assoic" { 
    
    subnet_id = aws_subnet.Public_subnet_ivolve.id 
    route_table_id = aws_route_table.PublicRT.id 
}

resource "aws_security_group" "web_SG" {
    name = "web_SRV_SG"
    description = "enable http accesss"
    vpc_id = data.aws_vpc.ivolve.id
    ingress {
        description = "http access"
        from_port = 80
        to_port = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}
resource "aws_security_group" "DB_SG" {
    name = "Database_security_g"
    description = "enable 3306"
    vpc_id = data.aws_vpc.ivolve.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ for subnet in aws_subnet.private_subnet_ivl : subnet.cidr_block]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
  
}
resource "aws_db_subnet_group" "db_subnet_group" { 
 name = "subnet to place rds instance "
subnet_ids = [for subnet in aws_subnet.private_subnet_ivl : subnet.id]
tags = {
  Name = "iovolve-db-sub-group"
}
}
resource "aws_db_instance" "db_instance" {
    engine = "mysql"
    instance_class = "db.t3.micro"
    identifier = "ivolve-db"
    username = "admin1111111"
    password = "AhmedEmad1"
    allocated_storage = 10
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
    skip_final_snapshot = true
    engine_version      = "8.0"
    vpc_security_group_ids = [aws_security_group.DB_SG.id]    
}