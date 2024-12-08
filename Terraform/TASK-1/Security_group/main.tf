resource "aws_security_group" "web_SG" {
    name = "web_SRV_SG"
    description = "enable http accesss"
    vpc_id = var.vpc_id
    ingress {
        description = "http access"
        from_port = 80
        to_port = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    
    } 
    ingress {
        description = "ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "MODULE-TASK-SG"
  }
}