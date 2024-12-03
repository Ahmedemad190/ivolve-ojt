# Install ansible and run Playbooks
# First you need to install ansible in your master machine in which u will push the playbooks
- for me i have create two amazon linux machines
on the master node do as follwoing
```
amazon-linux-extras install ansible2 -y
```
- then create a user for all ansible work
```
sudo useradd ansible_user
```
- create password
```
sudo passwd asnible_user
```
add the user into /etc/sudoers

![image](https://github.com/user-attachments/assets/0f027ce5-452a-4428-aa78-11e1f049b1c3)

- Enable the connection between the master and client node
```
su - ansible_user
vim /etc/sshd_config
```
```
Set "PasswordAuthentication yes"
```
- then restart sshd
```
service restart sshd
```
-copy the public key to the manged node
1.generate the key
```
ssh-keygen -t rsa
```
it will generate private key as id_rsa
and public key as id_rsa.pub 
```
ssh <manged_node_ip>
```
> [!IMPORTANT]
> ssh with user which u have created and placed it into /etc/suderos so it will give u no prompt

# the next step is ansible work 
- run a simple playbook
```
ansible -i inventory web -a "df -h"
```
- The output
![task_66](https://github.com/user-attachments/assets/65ae7a15-dbd8-409e-93db-8897359bbb68)
