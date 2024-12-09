terraform {
  backend "s3" {
    bucket         = "s3-mybucket-ivolve"        
    key            = "gloable/my-state-file/terraform.tfstate"     
    region         = "us-east-1"                       
    dynamodb_table = "state-lock-ivolve"             
    
  }
}
