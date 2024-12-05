# create vpc with 2 subnets , launch 2 EC2s with nginx and apache installed , and create and configure a load balancer to access the webserver
- First create the vpc
- give it CIDR:10.0.0.0/16
- Create the VPC
  ![image](https://github.com/user-attachments/assets/5e3de383-aa51-402a-b738-20613493e949)
- Configure the gateway
  and attach it to the the vpc u have created

  - then add the route table
  1.Go to Route Tables > Create Route Table
  2. give it name
  3. choose the vpc name
    - Add route
 Destination: 0.0.0.0/0.
Target: Select IGW u have created.

- Launch the ec2 isntances the public 
on the public subnet chosse the VPC u have create and choose the public subnet
Edit the security to allow  inbound HTTP (port 80) from 0.0.0.0/0
insert this in the apache ngninx
```
#!/bin/bash
yum update -y
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "Welcome to Nginx Server" > /usr/share/nginx/html/index.html
```
- Launch Instance 2 (Apache)
the same as the pervious but chosse the second public subnet u have created
User Data for apache
```
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Welcome to Apache Server" > /var/www/html/index.html
```
then launch the instance 
# configure the loadblancer and the target groups 

1.Navigate to EC2 > Load Balancers > Create Load Balancer.
2.Select Application Load Balancer.
3.Name: <Name>.
4.Scheme: Internet-facing.
5.Listeners: Add a listener for HTTP (port 80).
6.Availability Zones: Add <Public_subnet_1> and <subnet_2> from the az buttons.

# Configure Target Group:
- Target Type: Instance.
- Name: <Name>.
- Protocol: HTTP.
- Port: 80.
- Health Check: HTTP on /
- Register targets: Add machines u have created the nginx and the apache

- Assign the target group to loadblancer
copy the DNS name for the Loadblancer and test it 


![image](https://github.com/user-attachments/assets/c202ade2-56f6-40ff-a331-9b13031a5c2a)



