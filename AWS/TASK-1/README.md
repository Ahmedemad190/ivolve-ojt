# Lab 12: AWS Security
- Objective: Create AWS account, set billing alarm, create 2 IAM groups (admin-developer), admin group has admin 
permissions, developer group only access to ec2,  create admin-1 user with console access only and enable MFA & 
admin-2-prog user with cli access only and list all users and groups using commands, create dev-user with 
programmatic and console access and try to access EC2 and S3 from dev user
- first set billing alarm
1. Navigate to Billing > Preferences in the AWS Console.
2. Enable Billing Alerts.
4. Set up a Billing Alarm:
5. In CloudWatch, go to Alarms > Create Alarm.
6. Select Billing > Total Estimated Charge as the metric.
7. Set a threshold (e.g., USD 10).
![WhatsApp Image 2024-12-05 at 09 26 22_25798cf6](https://github.com/user-attachments/assets/811b6951-4946-4604-a107-34491594e13b)
8. Configure notification using an SNS topic
![WhatsApp Image 2024-12-05 at 09 26 38_2e074354](https://github.com/user-attachments/assets/d303d7d5-3fca-40e3-b7d3-5d667faf82e4)
9. add name and descrption for the alarm
![WhatsApp Image 2024-12-05 at 09 28 04_4d4e8117](https://github.com/user-attachments/assets/18f670e3-70d9-4a76-89cc-45519617a051)
10. after entring ur email
11. check ur inbox
![WhatsApp Image 2024-12-05 at 09 28 45_fafbdee4](https://github.com/user-attachments/assets/772607f3-7e74-4c0f-b937-bd67428a345b)
## Create IAM Users and Groups 
1. go to IAM DashBoard
   ![WhatsApp Image 2024-12-05 at 09 29 52_204c64ce](https://github.com/user-attachments/assets/afa38cd2-af91-476b-9057-549f9fe09106)
2. create user and groups
![WhatsApp Image 2024-12-05 at 09 31 57_4761ebed](https://github.com/user-attachments/assets/b8041c34-117c-45f9-87d3-cc976a0edceb)
3.th second group
![WhatsApp Image 2024-12-05 at 09 33 09_4960bb61](https://github.com/user-attachments/assets/8b6a6df3-c48d-40db-a32e-c895fadde023)
5. create user name it admin-1
![WhatsApp Image 2024-12-05 at 09 35 17_457ba44f](https://github.com/user-attachments/assets/4ee32426-1c86-4ecb-8612-26211fa3832f)

6.create the second user
![WhatsApp Image 2024-12-05 at 09 35 17_457ba44f](https://github.com/user-attachments/assets/097a9a7a-8eb6-4a96-8108-915654a34041)
7.create the dev-user 
![Uploading Screenshot 2024-12-05 095931.png…]()





