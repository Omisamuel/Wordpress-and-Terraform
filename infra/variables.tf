variable "bucket_name" {
  type        = string
  description = "Remote state bucket name"
  default     = null
}

variable "name" {
  type        = string
  description = "Tag name"
  default     = null
}


#Public Key
variable "public_key" {
  type        = string
  description = "WP Project 1 Public key for EC2 instance"
  default     = null
  sensitive   = true
}


variable "instance_2_public_key" {
  description = "Public key path for Bastion instance"
  type        = string
  sensitive   = true
}


#EC Instance
variable "ami_id" {
  type        = string
  description = "WP Project 1 AMI Id for EC2 instance"
  default     = null
}

#EC Instance
variable "image_id" {
  type        = string
  description = "Bastion Host"
  default     = null
}



#Hosted Name
variable "domain_name" {
  type        = string
  description = "Name of the domain"
  default     = null
}



#Network
variable "public_subnet_cidr_block" {
  default = ""
}

variable "wp_vpc_eu_vpc_id" {
  default = ""
}

variable "eu_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
  default     = null
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = null
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = null
}

variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = null
}

variable "vpc_name" {
  type        = string
  description = "WP Project 1 VPC"
  default     = null

}

#variable "wp_private_subnets" {}




#RDS

variable "mysql_db_identifier" {
  type        = string
  description = "Name of the domain"
  default     = null
}
variable "mysql_username" {
  type        = string
  description = "Name of the user"
}

variable "mysql_password" {
  type        = string
  description = "Password for mysql"
  default     = null
}
variable "mysql_dbname" {
  type        = string
  description = "Name of the mysql"
  default     = null
}

variable "configuration" {
  description = "The total configuration, List of Objects/Dictionary"
  default     = [{}]
}

