output "web_instance_public_ip" {
  value = aws_instance.event_instance.public_ip
}

output "web_instance_public_dns" {
  value = aws_instance.event_instance.public_dns
}

output "monitoring_instance_public_ip" {
  value = aws_instance.monitoring_instance.public_ip
}

output "monitoring_instance_public_dns" {
  value = aws_instance.monitoring_instance.public_dns
}
