variable "Pub_cidr_block" {
  type = string
  default = "10.0.0.0/26"

}

variable "a_z" {
    default = "us-east-1a" 
}
variable "priv_sub_cidr_block" {
  type = string
  default = "10.0.0.0/26" 
}
variable "a_z_priv" {
    default = "us-east-1b"
}
variable "mult_priv_sub" {
    type = map(string)
    default = {
      "us-east-1a" = "10.0.0.64/26"
       "us-east-1b" = "10.0.0.128/26"
    }
  
}