 # Lab 16: Serverless Application Development Objective: Build a serverless application using AWS Lambda, API Gateway, and DynamoDB 
 
1- First of all we need to create aws role permission policy should be 
![image](https://github.com/user-attachments/assets/7c84f5bc-1e95-4b44-a00a-be2711e1cc0e)

which means taht lambda using this role to perfrom any action on Dynamodb which will be create next 
- Next step to create lambda function
- choose the name and the run time then click create function
![image](https://github.com/user-attachments/assets/a82e4297-0314-4527-98da-5300b26f5a31)

attach it to the role u have created 
![image](https://github.com/user-attachments/assets/9b716cd6-6435-4d7f-9959-34e297bd0469)
- Upload the function as a zip file to lambda
- Next step is to create the Dynamodb table
Dynamodb>Tables>Create table
![image](https://github.com/user-attachments/assets/45e12acb-e566-4240-b842-295c1fc4f5a7)
## API gateway section 
API Gateway>APIs>Create API>REST API 
![image](https://github.com/user-attachments/assets/5b42dd8b-d222-4b99-9898-7a1f9262a329)


![image](https://github.com/user-attachments/assets/45d344b3-84de-44ad-b275-eef277997698)

then create the methods 
![image](https://github.com/user-attachments/assets/7b367f34-dcce-404d-b9b5-9eba9290febe)

on our lambda function we have two methods post and get  so we will create two method post and get as following 
![image](https://github.com/user-attachments/assets/bd8683b3-2669-46f4-b17a-8c16d98d875b)

- do the same for the POST function 
- then deploy the API
![image](https://github.com/user-attachments/assets/003e2f69-7aea-42b3-909c-f1e1425a2ce9)

- Copy the invoke url and paste into a new tab u should see the following

![image](https://github.com/user-attachments/assets/e61c7c8b-a624-4d33-861e-699fc4cc4130) 

fill it with info and click submit  u should see a success msg 

