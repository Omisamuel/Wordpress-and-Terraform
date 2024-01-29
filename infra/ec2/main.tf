resource "aws_instance" "wordpress_ec2_01" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.project_name
  }

  key_name = "wordpress-deployer-key"
  vpc_security_group_ids = var.sg_for_wp_ec2
  subnet_id = var.subnet_id
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.wordpress_apache2_install

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

resource "aws_key_pair" "wordpress_deployer" {
  key_name   = "wordpress-deployer-key"
  public_key = var.public_key
}
