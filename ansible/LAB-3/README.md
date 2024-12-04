
- First create invnetory file 
```
[web]
172.31.28.196  ansible_ssh_pass=P@$$w0rd
```

- Create ansible.cfg for configtuin such as inventory name and the remote_user

Create secert.yml : to store the text in a secert way 
```
ansible-vault encrypt secrets.yml
```
