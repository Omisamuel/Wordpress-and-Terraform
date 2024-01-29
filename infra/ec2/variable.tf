variable "ami_id" {}

variable "instance_type" {}

variable "project_name" {}

variable "subnet_id" {}

variable "sg_for_wp_ec2" {}

variable "enable_public_ip_address" {}

variable "wordpress_apache2_install" {}

variable "public_key" {
  default = null
}
variable "wordpress_acm_arn" {
  default = null
}