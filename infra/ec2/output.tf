output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /home/ubuntu/keys/aws_ec2_terraform ubuntu@", aws_instance.wordpress_ec2_01.public_ip)
}

output "wordpress_ec2_01_instance_id" {
  value = aws_instance.wordpress_ec2_01.id
}