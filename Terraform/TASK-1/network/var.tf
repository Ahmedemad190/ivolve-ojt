variable "cidr_block" { 
    type = string
    default = "10.0.0.0/16"
}
variable "mult_pub_sub" {
    type = map(string)
    default = {
      "us-east-1a" = "10.0.1.0/24"
       "us-east-1b" = "10.0.2.0/24"
    } 
}
variable "aws_region" { 
    type = string
}
variable "availability_zone" { 
    type = list(string)
}
variable "aws_public_subnet_cidrs" {
    type = list(string)
}