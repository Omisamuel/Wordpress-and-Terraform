# LOAD BALANCER
resource "aws_security_group" "elb_security_group" {
  vpc_id      = var.vpc_id
  name        = var.sg_for_elb
  description = "ssh to access WP security group"

  egress {
    description = "Allow outbound traffic to specific IP addresses or ranges"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    self        = true
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    self        = true
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb security group"
  }

}


#bastion host Server
resource "aws_security_group" "bastion_security_group"{
  vpc_id      = var.vpc_id
  name        = var.bastion_host
  description = "ssh to access WP security group"

  egress {
    description = "Allow outbound traffic to specific IP addresses or ranges"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    self        = true
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion security group"
  }
}


# WP Instance Security Group
resource "aws_security_group" "sg_wp_instance" {
  vpc_id      = var.vpc_id
  name        = var.sg_for_wp_ec2
  description = "enable access from WP SG to bastion"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    self        = true
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_security_group.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    self        = true
    protocol    = "tcp"
    security_groups = [aws_security_group.elb_security_group.id]
  }
  tags = {
    Name = "WP Instance Security Group"
  }
}


# Security Group for RDS
resource "aws_security_group" "rds_mysql_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidr_block # replace with your EC2 instance security group CIDR block
  }
  tags = {
    Name = "Security Group for RDS"
  }
}
