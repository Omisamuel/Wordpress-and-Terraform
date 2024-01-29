variable "image_id" {
  default = ""
}
variable "instance_type" {
  default = ""
}
variable "enable_public_ip_address" {
  description = "Flag to enable public IP for the bastion host"
  type        = bool
  default     = true  # or false, depending on your requirement
}

variable "instance_2_public_key" {
  default = ""
}
variable "bastion_server_SG" {
  default = ""
}
variable "subnet_id" {
  default = ""
}
variable "tag_name" {
  default = ""
}