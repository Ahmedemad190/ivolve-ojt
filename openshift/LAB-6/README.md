# Lab 31: Network Configuration

-  Build a new image from Dockerfile in https://github.com/IbrahimmAdel/static-website.git
```
git clone https://github.com/IbrahimmAdel/static-website.git
```
then built the image 
```
docker build -t 3omda1/static-website:latest .
```
verify the image is existed 

![image](https://github.com/user-attachments/assets/39a6dac0-55e4-4ab7-a609-38eaad5b8427)

then login in docker through 
```
docker login <user_name>
```
then it will prompt u to enter the password

![image](https://github.com/user-attachments/assets/03784dea-5bf0-48f8-b1a5-f07c617fda93)


then push the image 
```
docker push 3omda1/static-website
```
then create the deploymnet 
![image](https://github.com/user-attachments/assets/41aa312c-328f-4d87-8c3a-e8d156beffa0) 


create service.yml to expose the service 
```
apiVersion: v1
kind: Service
metadata:
  name: static-website-service
spec:
  selector:
    app: static-website
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```
apply it with ``` kubectl apply -f <file_name>```

then create nework-policy.yml 
to restricts traffic to the NGINX pods only from other pods in the same namespace.
![image](https://github.com/user-attachments/assets/e8068469-1b9b-4f0d-a546-95e399ad218f)

