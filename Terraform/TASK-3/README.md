 # Lab 19: Remote Backend and LifeCycles Rules
- Implement the below diagram with Terraform.
-  Store state file in remote backend.
-   Use create_before_destroy Lifecycle on the EC2 and verify it. Compare between different Lifecycles Rules.
![image](https://github.com/user-attachments/assets/3bc8a3df-dc26-41c3-9a5f-268853e1a2c6)

- create the backned
- first create the bucket with a unique name

![image](https://github.com/user-attachments/assets/473e9f36-e0d0-45b6-b6a9-73c4a484e5e8)

the differnece between the remote state and local remote state is u don't need the tfstate file to be located in ur local machine so u can have acces it any time

- Then start by create the actula infra start with the vpc
with cidr:10.0.0.0/16
and a subnet with cidr: 10.0.0.0/24
in this subnet create the ec2 with a security group allow and internet gateway and a public route table and associate it to the public subnet so u can access internet
- confiugre the cloudwatch so if the cpu exceded 70% it will use sns to send email which u will configure it later

verify ur configurtion with this email 
![image](https://github.com/user-attachments/assets/500b1935-ac5c-4310-bfd0-cd933b331dae)

the s3 bucket 
![image](https://github.com/user-attachments/assets/85dd6c3a-fd15-446e-a8cc-6f88926198c5)
