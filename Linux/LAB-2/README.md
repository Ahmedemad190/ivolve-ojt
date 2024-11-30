# create a  bash script to chekc the disk usage for the root file system 



- first of all we need to install  smtp client to send emails from command line
```
sudo apt update
sudo apt install msmtp msmtp-mta
```
- edit the configurtion file
```
nano ~/.msmtprc
```
it should be as following 
```
# General settings
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.msmtp.log

# Account settings
account        default
host           smtp.gmail.com
port           587
from           your_email@gmail.com
user           your_email@gmail.com
password       your_email_password
```
> [!WARNING]
> change <your_email@gmail.com> with your email
> change <your_email@gmail.com> with ur email
> change <your_email_password> with ur password
ع ش
شش
