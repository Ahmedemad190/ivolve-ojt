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

```
