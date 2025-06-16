data "aws_ami_ids" "developer_ami" {
  owners      = ["amazon"]

  // Filter for the latest Amazon Linux 2 AMI
  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-*-kernel-6.1-x86_64"]
  }

}

resource "aws_instance" "developer_web_server" {
  ami           = data.aws_ami_ids.developer_ami.ids[0]
  count         = 1
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.developer_subnet.id
  key_name      = aws_key_pair.developer_key.key_name
  vpc_security_group_ids = [ aws_security_group.developer_sg.id ]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  # https://cloudinit.readthedocs.io/en/latest/topics/modules.html
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html
  user_data = <<-EOF
    #cloud-config
    repo_update: true
    repo_upgrade: all
    packages:
      - httpd
    runcmd:
      - systemctl enable --now httpd
    EOF

  tags = merge(
    {
      Name = "${var.env_prefix}-web-server"
    },
    local.tags
  )
}

resource "aws_eip" "developer_eip" {
  instance = aws_instance.developer_web_server[0].id
  tags = merge(
    {
      Name = "${var.env_prefix}-eip"
    },
    local.tags
  )
}