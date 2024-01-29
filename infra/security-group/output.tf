output "sg_for_wp_ec2_id" {
  value = aws_security_group.sg_wp_instance.id
}

output "sg_bastion_security_group" {
  value = aws_security_group.bastion_security_group.id
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}