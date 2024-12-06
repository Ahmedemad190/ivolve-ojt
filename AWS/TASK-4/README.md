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
