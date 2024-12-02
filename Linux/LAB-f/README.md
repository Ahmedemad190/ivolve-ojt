# enable SSH netween two machines 
- First create the keypair
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa 
```
- Copy the public key to the target mahcine
```
ssh-copy-id -i ~/.ssh/id_rsa.pub username@<target_vm_ip>
```
