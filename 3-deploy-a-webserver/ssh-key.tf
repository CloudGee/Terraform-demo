resource "tls_private_key" "developer_key_content" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "developer_key" {
  key_name   = "developer-key"
  public_key = tls_private_key.developer_key_content.public_key_openssh
}