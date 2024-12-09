# Lab 20: Terraform Variables and Loops
- Implement the below diagram with Terraform using variables for all arguments.
- do not repeat code.
- Install Nginx, Apache using remote provisioner.
- create the NAT Gateway manually then make terraform manage it ‘Terraform import’.
- Output public ip and private ip of EC2s


 ![image](https://github.com/user-attachments/assets/5064b35b-b283-4ecc-9cb2-d57533da933c)



# Terraform AWS Infrastructure Setup

This Terraform configuration sets up a basic AWS infrastructure including public and private subnets, an internet gateway, a NAT gateway, route tables, security groups, and EC2 instances running Nginx and Apache.

## Resources

### VPC
- **VPC**: A virtual private cloud.

### Subnets
- **Public Subnet**: A public subnet with a public IP assigned to each instance.
- **Private Subnet**: A private subnet without public IPs.

### Internet Gateway
- **Internet Gateway**: Allows internet access for the public subnet.

### NAT Gateway
- **NAT Gateway**: Allows instances in the private subnet to access the internet.

### Route Tables
- **Public Route Table**: Routes traffic from the public subnet to the internet gateway.
- **Private Route Table**: Routes traffic from the private subnet to the NAT gateway.

### Security Groups
- **Public Security Group**: Allows HTTP, HTTPS, and SSH access to the public subnet.
- **Private Security Group**: Allows HTTP access from the public subnet.

### EC2 Instances
- **Nginx Server**: An EC2 instance in the public subnet running Nginx.
- **Apache Server**: An EC2 instance in the private subnet running Apache.

in the begining we need to import the resource we have create wwhich is the vpc 
by 
```              <resource.resorucename> <resource_id>
terraform import aws_vpc.exist vpc-0601da0234c315dca 
```

- fetch teh vpc data
```
resource "aws_vpc" "exist" {
    tags = {
      Name = "ivolve-20" #the name of the vpc in the aws console
    }
}
```
![image](https://github.com/user-attachments/assets/e46eefb3-aedc-4eb6-80f0-bd90d0a1ef1d) 

- the next step is createing the public subnet in the vpc we have imported perivously
```
resource "aws_subnet" "Public_1" {
  vpc_id = aws_vpc.exist.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true #mean every ec2 in this subnet will not need to asspicate_public_ip it takes public ip automatic
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public-sub-TASK-final"
  }
}
```
do the same for the private subnet 
```
resource "aws_subnet" "Private_2" {
  vpc_id = aws_vpc.exist.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-subnet-TASK-FINAL"
  }
}
```
- then create the innternet gateway
the role of the internet gateway makes ur vpc connected to internet 
```
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.exist.id
  tags = {
    Name = "Internet_gateway"
  }
}
```
- then create the EIP
the pramter "domain="vpc" " means the eip associte to vpc 
```

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "NAT GATEWAY_EIP"
  }
}
```
- Create nat gateway
allocation_id = aws_eip.nat_eip.id #assoicate the NAT gateway with EIP we have create earlier
subnet_id = aws_subnet.Public_1.id # it means it place the nat gateway into the public subnet so the nat gateway can access internet with EIP 
```
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.Public_1.id
  tags = {
    Name = "NAT GATEWAY"
  }
}
![image](https://github.com/user-attachments/assets/76b088fa-e48b-4d6f-94e8-e9ce44dec1bd)

```
- the route table
determine the destiontion for any resource use to access internet
cidr_block = "0.0.0.0/0" it means anything have no route will go to internet gateway
gateway_id = aws_internet_gateway.igw.id makes every resource in public subnet access internet through internet gateway 
```
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
```
attach the public subnet to the route table 
```
resource "aws_route_table_association" "public_subnet_assoicate" {
  subnet_id = aws_subnet.Public_1.id
  route_table_id = aws_route_table.PublicRT.id
}
```
so the servers in this subnet can accesss internet 
```
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
```
cidr_block = "0.0.0.0/0" every traffic will go to nat gateway to access intrnet 
- assoicate the private table to the route table
```
resource "aws_route_table_association" "Private_assoc" {
  subnet_id = aws_subnet.Private_2.id
  route_table_id = aws_route_table.private_route_table.id
}
```
associate the private subnet to the route table so the servers can use the nat gateway to access internet 
the final stage is creating the security group for ec2 in public subnet and private subnet 
```

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
```
it's a basic security grpup allow ssh and http and https from anywhere in internet 
the private security group 
```
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
```
cidr_blocks = [aws_subnet.Public_1.cidr_block] 
this is an important part which means that allow the servers in the private subnet ot communicate with servers in aws_subnet.Public_1 only with cidr=[10.0.0.0/24] 
to verify ur work open the nginx server and try to through ssh or any alternive way 
and type the follwoing 
```
 curl 10.0.2.107  | grep "apache"
```
10.0.2.107 is the private  ip of the apcahe server we have create ealier 
u should see someting like that 
![image](https://github.com/user-attachments/assets/c08ac15f-a1ba-4301-b0c7-8bf54c63dda9)



after terraform apply u should see that  
![image](https://github.com/user-attachments/assets/bcc1739b-484b-4c2d-87bb-8d7e82fecf78)

check the output file 
