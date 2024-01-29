output "ssh_connection_string_for_bastion" {
  value = format("%s%s", "ssh -i /home/ubuntu/keys/aws_bastion_key ubuntu@", aws_instance.bastion-host.public_ip)
}

output "bastion-host_instance_id" {
  value = aws_instance.bastion-host.id
}

#TO PRINT

/*
output "bastion-host_public_ip" {
  value = aws_instance.bastion-host.public_ip
}*/
