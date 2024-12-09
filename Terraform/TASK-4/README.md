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
