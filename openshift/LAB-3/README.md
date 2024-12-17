#  Lab 29: Storage Configuration

first create the task.yml to create the deployment 

![image](https://github.com/user-attachments/assets/4d4fa2aa-a6a7-4743-adc0-9c35783be026)

apply it with 
```
kubectl apply -f <>
```
then create the pvc 

![image](https://github.com/user-attachments/assets/b67a2dd4-a75a-4d90-b5dd-5de141e45f8d)

apply it with 

```
kubectl apply -f <>
```

![image](https://github.com/user-attachments/assets/af780385-b7a7-46c0-8919-fd9eb4e86d64)

then update the deployment file with 
![image](https://github.com/user-attachments/assets/400e7b9d-d96a-47df-abfb-74a3ad2b424c)

check the pods with 

```
kubectl get pods 
```

![sql5](https://github.com/user-attachments/assets/feb8b27d-fb1e-48da-becc-0eeb7f9f901c)

then delete the pod and rebeate the pervious steps
