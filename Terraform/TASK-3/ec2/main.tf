resource "aws_instance" "ivolve-ec2" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  lifecycle {
      create_before_destroy = true
  }
  tags = {
    Name = "ivolve-ec2"
  }
}