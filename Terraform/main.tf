module "networking" {
    source = "./modules/network"
    aws_region = "us-east-1"  
    availability_zone = ["us-east-1a","us-east-1b"]
    aws_public_subnet_cidrs = module.networking.public_ids
  
}
module "security_group-1" {
    source = "./modules/security_group"
    vpc_id = module.networking.vpc_id_value.id
  
}
module "compute" {
    source = "./modules/ec2"
    public_subnet_id = module.networking.public_ids
    web_security = module.security_group-1.web-sg
    vpc_id = module.networking.vpc_id_value.id
}