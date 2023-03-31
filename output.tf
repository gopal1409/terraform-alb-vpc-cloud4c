output "instance_app_server_public_ip" {
  value = aws_instance.app-server.*.public_dns
}
output "load_balancer_dns_name" {
  description = "Load balancer DNS Name"
  value = aws_lb.front.dns_name
}