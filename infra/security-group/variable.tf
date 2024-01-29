variable "sg_for_wp_ec2" {
  default = null
}
variable "vpc_id" {
  default = null
}
variable "sg_for_elb" {
  default = null
}
variable "public_subnet_cidr_block" {
  default = null
}

#variable "sg_wp_instance" {}
variable "bastion_host" {}