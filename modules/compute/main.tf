resource "aws_instance" "web" {
  count = var.web_count

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.web_security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name       = "web-${count.index + 1}"
    Tier       = "web"
    Experiment = "02"
    ManagedBy  = "Terraform"
  }
}

resource "aws_instance" "db" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.db_security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  depends_on = [aws_instance.web]

  tags = {
    Name       = "db-1"
    Tier       = "database"
    Experiment = "02"
    ManagedBy  = "Terraform"
  }
}