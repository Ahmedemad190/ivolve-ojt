variable "vpc_id" { 
    type = string
    description = "vpc ID"
  
}

variable "inst_type" {
    default = "t2.micro"
    type = string
  
}
variable "public_subnet_id" {
  type = list(string)
}
variable "ami_name" {
    type = string
    default = "ami-005fc0f236362e99f"
  
}
variable "web_security" {
    type = string
  
}