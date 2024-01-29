
module "network" {
  source               = "./network"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  cidr_private_subnet  = var.cidr_private_subnet
  eu_availability_zone = var.eu_availability_zone
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  instance_tenancy     = "default"
}


module "security_group" {
  source                   = "./security-group"
  sg_for_elb               = "SG for ELB to enable SSH(22) and HTTP(80)"
  vpc_id                   = module.network.wp_vpc_eu_vpc_id
  public_subnet_cidr_block = tolist(module.network.public_subnet_cidr_block)
  bastion_host             = "SG for Bastion to enable SSH access"
}

module "bastion-server" {
  source                = "./bastion-host"
  image_id              = var.image_id
  instance_type         = "t2.micro"
  tag_name              = "Bastion-Host Linux EC2"
  instance_2_public_key = var.instance_2_public_key
  bastion_server_SG     = [module.security_group.sg_bastion_security_group]
  subnet_id             = tolist(module.network.wp_public_subnets)[0]
}


module "ec2" {
  source                    = "./ec2"
  ami_id                    = var.ami_id
  instance_type             = "t2.micro"
  subnet_id                 = tolist(module.network.wp_private_subnets)[0]
  sg_for_wp_ec2             = [module.security_group.sg_for_wp_ec2_id]
  enable_public_ip_address  = false
  wordpress_apache2_install = templatefile("./template/wordpress.sh", {}) #install Apache on EC2 instance
  project_name              = "WordPress-Instance"
  public_key                = var.public_key
}

module "load-balancer" {
  source                         = "./load-balancer"
  elb_internal                   = false
  elb_name                       = "wp-elb"
  elb_project_name               = "WordPress-elb"
  elb_target_port                = 80
  elb_wp_listener_arn            = "elb-wordpress"
  elb_wp_listener_default_action = "forward"
  elb_wp_target_group_arn        = module.lb-target-group.alb_web_elb_tg_arn
  elb_wp_listener_port           = 80
  elb_wp_listener_protocol       = "HTTP"
  load_balancer_type             = "application"
  sg_for_elb                     = module.security_group.sg_for_wp_ec2_id
  subnet_id                      = tolist(module.network.wp_public_subnets)
  wordpress_web01_id             = module.ec2.wordpress_ec2_01_instance_id
  elb_wp_https_listener_port     = 443
  elb_wp_https_listener_protocol = "HTTPS"
  wp_acm_arn                     = module.aws_ceritification_manager.wp_acm_arn
}


module "lb-target-group" {
  source                   = "./load-balancer-target-group"
  elb_wp_tg_default_action = "forward"
  elb_wp_tg_port           = 80
  elb_wp_tg_project_name   = "WordPress"
  elb_wp_tg_protocol       = "HTTP"
  #  elb_wp_tg_type           = "ip"
  vpc_id             = module.network.wp_vpc_eu_vpc_id
  wordpress_web01_id = module.ec2.wordpress_ec2_01_instance_id
}


module "hosted_zone" {
  source          = "./hosted-zone"
  domain_name     = "omsam.de"
  aws_lb_dns_name = module.load-balancer.elb_wp_dns_name
  aws_lb_zone_id  = module.load-balancer.elb_wp_zone_id
}

module "aws_ceritification_manager" {
  source         = "./certificate-manager"
  domain_name    = "omsam.de"
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}


module "rds_db_instance" {
  source               = "./rds"
  db_subnet_group_name = "dev_proj_1_rds_subnet_group"
  subnet_groups        = tolist(module.network.wp_public_subnets)
  rds_mysql_sg_id      = module.security_group.rds_mysql_sg_id
  mysql_db_identifier  = var.mysql_db_identifier
  mysql_username       = var.mysql_username
  mysql_password       = var.mysql_password
  mysql_dbname         = var.mysql_dbname
}
