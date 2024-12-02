# enable SSH between two machines 
- First create the keypair
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa 
```
- Copy the public key to the target mahcine
```
ssh-copy-id -i ~/.ssh/id_rsa.pub username@<target_vm_ip>
```
> [!IMPORTANT]
> u entered the username u have created on the target mahcine
- Edit the ssh config file
```
nano ~/.ssh/config
```
- then add the follwoing
```
Host <the_name_you_want_to_call_the_server_with>
    HostName <target_vm_ip>
    User username
    IdentityFile ~/.ssh/id_rsa #private key location 
```
test it with ssh <the_name_you_want_to_call_the_server_with>
