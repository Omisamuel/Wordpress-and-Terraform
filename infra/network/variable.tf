#default
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "instance_tenancy" {}
variable "enable_dns_support" {}
variable "enable_dns_hostnames" {}


#Public Subnet
variable "eu_availability_zone" {}
#variable "map_public_ip_on_launch" {}
variable "cidr_public_subnet" {}

#Private Subnet
variable "cidr_private_subnet" {}

