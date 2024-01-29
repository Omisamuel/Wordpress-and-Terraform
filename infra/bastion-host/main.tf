resource "aws_instance" "bastion-host" {
  ami           = var.image_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name = "aws_bastion_key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids = var.bastion_server_SG
  associate_public_ip_address = var.enable_public_ip_address

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "aws_bastion_key"
  public_key = file(var.instance_2_public_key)
}
