# Lab 15: SDK and CLI Interactions Objective: Use the AWS CLI to Create an S3 bucket, configure permissions, and upload/download files to/from the bucket. Enable versioning and logging for the bucket
- First of all you need to login with email have permission to access s3 buckets
```
aws configure
```
- enter ur creds
then create the buckets
```
 aws s3api create-bucket --bucket <bucket-name> --region us-east-1
```
- Disable the block public access access
```
aws s3api put-public-access-block --bucket <Bucket-name> --public-access-block-configuration  "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```
- create the bucket-policy.json in which grant permission to download files from the bucket you allow get action
 ```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<your-bucket-name>/*"
    }
  ]
}
```
- Upload file to the bucket
```
aws s3 cp <local-file-path> s3://<your-bucket-name>/
```
![image](https://github.com/user-attachments/assets/a9e43263-0aca-4cb2-98cd-8b3c836d5af0)
- Download from the bucket
```
aws s3 cp s3://<your-bucket-name>/<file-name> <destination-path>
```
- Enable versionning
```
aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled
```
- Enable Logging
for enable logging you need to create another bucket to store the logging logs and give it the required permissions
1. create the bucket
```
aws s3api create-bucket --bucket <bucket-name> --region us-east-1
```
2. use a json file to enalbe logging
- create the json file
```
{
  "LoggingEnabled": {
    "TargetBucket": "<bucket-name>",
    "TargetPrefix": "logs/"
  }
}

```
3. enable logging
```
aws s3api put-bucket-logging --bucket <bucket-name> --bucket-logging-status file://<path-for-json-file>
```
