# Terraform AWS Infrastructure Setup

This Terraform configuration sets up a basic AWS infrastructure including public and private subnets, an internet gateway, route tables, security groups, and an RDS instance.

## Resources

### Subnets
- **Public Subnet**: A public subnet with a public IP assigned to each instance.
- **Private Subnets**: Multiple private subnets.

### AMI
- **Ubuntu AMI**: The latest Ubuntu 22.04 AMI.

### EC2 Instance
- **Web Server**: An EC2 instance in the public subnet with HTTP access.

### Internet Gateway
- **Internet Gateway**: Allows internet access for the public subnet.

### Route Table
- **Public Route Table**: Routes traffic from the public subnet to the internet gateway.

### Security Groups
- **Web Security Group**: Allows HTTP access to the web server.
- **Database Security Group**: Allows MySQL access within the private subnets.

### RDS Instance
- **MySQL Database**: An RDS instance in the private subnets.

## Configuration Details

### Public Subnet
```hcl
resource "aws_subnet" "Public_subnet_ivolve" {
  vpc_id = data.aws_vpc.ivolve.id
  cidr_block = var.Pub_cidr_block
  availability_zone = var.a_z
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet-ivolve"
  }
### Private Subnets
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

- Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.ivolve.id
  tags = {
    Name = "igw-4-ivolve"
  }
}
- Route Table
route traffic of the ec2 in the public subnet to internet 
resource "aws_route_table" "PublicRT" {
  vpc_id = data.aws_vpc.ivolve.id
  route {
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

Security Groups
resource "aws_security_group" "web_SG" {
  name = "web_SRV_SG"
  description = "enable http access"
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
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# security group
resource "aws_security_group" "DB_SG" {
  name = "Database_security_g"
  description = "enable 3306"
  vpc_id = data.aws_vpc.ivolve.id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [for subnet in aws_subnet.private_subnet_ivl : subnet.cidr_block]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

- RDS Instance
resource "aws_db_instance" "db_instance" {
  engine = "mysql"
  instance_class = "db.t3.micro"
  identifier = "ivolve-db"
  username = "admin1111111"
  password = "AhmedEmad1"
  allocated_storage = 10
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
  skip_final_snapshot = true
  engine_version = "8.0"
  vpc_security_group_ids = [aws_security_group.DB_SG.id]
}
1.Initialize Terraform:
```
terraform init

```
2.Apply changes

```
terraform apply 

```

3.verify resources :
check AWS mangemnet console
- Notes
use account have the apporiprate accesss
