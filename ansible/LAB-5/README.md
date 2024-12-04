# Lab 11: Ansible Dynamic Inventories Objective: Set up Ansible dynamic inventories to automatically discover and manage  infrastructure. Use Ansible Galaxy role to install Apache
- install boto3 and botocore
```
   34  sudo apt install boto3 botocore 
   35  sudo apt update
   36  sudo apt install -y python3-pip 
   37  pip3 install boto3 botocore 
   38  python3 -c "import boto3; import botocore; print('Installed successfully')"

```
- install galaxy collection
```
 sudo ansible-galaxy collection install amazon.aws 
```
- then put your credentials
```
sudo apt  install awscli
aws configure
```
- it will prompot to enter ur creds
- then install the role
```
ansible-galaxy install geerlingguy.apache
```
- print the graph
```
 ansible-inventory -i aws_ec2.yml --graph
```
it should print this 
![image](https://github.com/user-attachments/assets/c99dd7f3-e076-4f6f-a231-996dd5fd2a8d)
- run the playbook
```
ansible-playbook -i aws_ec2.yml playbook.yml 
```
- it should print this
![image](https://github.com/user-attachments/assets/aebd8f35-439a-4095-9fe9-2984586671d9)
- to enusre it's running
![WhatsApp Image 2024-12-04 at 18 30 53_0e20d0e6](https://github.com/user-attachments/assets/81b6d818-89d0-475b-a5a1-ba36957dae25)

