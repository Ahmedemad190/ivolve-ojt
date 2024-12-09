# Outputs
output "nat_eip" {
  value = aws_eip.nat_eip.public_ip
}

output "nginx_public_ip" {
  value = aws_instance.nginx_server.public_ip
}

output "apache_private_ip" {
  value = aws_instance.apache_server.private_ip
}
