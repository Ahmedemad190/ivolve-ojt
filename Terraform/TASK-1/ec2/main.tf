resource "aws_instance" "task-module" {
    
    instance_type = var.inst_type 
    subnet_id = var.public_subnet_id[count.index]
    count = 2
    ami = var.ami_name 
    vpc_security_group_ids = [var.web_security] 
    associate_public_ip_address = true
    
user_data = <<-EOF
                #!/bin/bash
                apt-get update
                apt-get install -y nginx
                systemctl start nginx
                systemctl enable nginx
                
                # Create a custom message for the default Nginx page
                echo "<h1>Welcome to My Custom Nginx Server!</h1><p>This is a custom message displayed on your Nginx server.</p>" > /var/www/html/index.html
              EOF

tags = {
  Name = "Public_insatnce_module-${count.index }"
}
} 

try to http://<public_ec2> 

u should see the welcome page for nginx !



