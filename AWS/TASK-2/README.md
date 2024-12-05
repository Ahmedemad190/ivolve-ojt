# Objective: Create a VPC with public and private subnets and 1 EC2 in each subnet, configure private EC2 security group to only allow inbound SSH from public EC2 IP, SSH to the private instance using bastion host
1. Create VPC 
![image](https://github.com/user-attachments/assets/8ea676a3-3cd1-4afc-9a30-d12976a5e7d7)

2. Create two subnets one public and private
![image](https://github.com/user-attachments/assets/349e9a51-255a-4730-a0a0-9d2533360ab5)

3. Confiure internt gateway
![image](https://github.com/user-attachments/assets/341e5928-cb63-45b7-903c-0a1db1efe461)

4. Create security group For public subnet
![image](https://github.com/user-attachments/assets/cde4d6e4-7854-41c4-8f65-321dd1e1b8e4)
- Allow inbound rules inbound type: SSH , Source:0.0.0.0/0
6. Create securtiy group for private subnet
![image](https://github.com/user-attachments/assets/54eb60ad-9c5f-45b2-a92a-bfffc678da2c)
The same as the pervious and the source should be the security group of the the Public ec2
7. launch EC2 instance (Public subnet)
attach it to the vpc u have created and the security group
7. launch EC2 instance (Private subnet)
  the same as pervious
  8. use ant third party tool to access the machine
  ```
  ssh -i private/key/path ec2-user@<public-ec2-public-ip>
  ```
  9. then ssh into from the public to the private
     ```
ssh -i private/key/path ec2-user@<private-ec2-private-ip>
     ```

     ![image](https://github.com/user-attachments/assets/53f6d384-f6f9-41a6-9c99-a8f66b59efd9)
