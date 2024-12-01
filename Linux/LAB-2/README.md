# create a  bash script to chekc the disk usage for the root file system the script should run daily



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

> [!IMPORTANT]
> you cannot add ur password as plaintext
1. Go to your Google Account Security Page.
2. Enable 2-Step Verification (if not already enabled).
3. Scroll to App Passwords and create a new password for "Mail" and your device.
4. Replace your password in the ~/.msmtprc file with the App Password.
5. copy the code and add into ~/.msmtprc replace it with email_password
# the main script 
```
#!/bin/bash

# Set the threshold percentage
THRESHOLD=10

# Get the current disk usage percentage for the root filesystem
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check if the current usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    # Create the email content
    echo -e "To: <enter_email>\nFrom: <enter_email>\nSubject: Disk Space Alert\n\nThe root filesystem usage is at ${USAGE}% which exceeds the threshold of ${THRESHOLD}%." > /tmp/disk_alert.txt

    # Send the email using msmtp
    msmtp --debug --from=default -t < /tmp/disk_alert.txt
fi
```
- Edit crontab to make the script run daily
  ```
  crontab -e
  ```
  - check the crontab job
  ```
crontab -l
  ```
  - and add the following to make script runs daily at 5:00 pm
  ```
  0 17 * * * /path/to/script
  ```
- to test the script
```
bash <script_path>
```
# The output should be like that 
![image](https://github.com/user-attachments/assets/45dda54c-54e3-414b-8ca1-95f506e78933) 


