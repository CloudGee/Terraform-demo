output "webserver_ip" {
  value = aws_eip.developer_eip.public_ip
}

output "webserver_private_key" {
  value     = tls_private_key.developer_key_content.private_key_pem
  sensitive = true
}