variable "elb_name" {}
variable "elb_internal" {}
variable "load_balancer_type" {}
variable "sg_for_elb" {}
variable "subnet_id" {}
variable "wp_acm_arn" {}

#aws target group
variable "elb_project_name" {}
#variable "alb_web_elb_tg_arn" {}
variable "wordpress_web01_id" {}

variable "elb_target_port" {}

#aws lb listener
variable "elb_wp_listener_arn" {}
variable "elb_wp_listener_port" {}
variable "elb_wp_listener_protocol" {}
variable "elb_wp_listener_default_action" {}
variable "elb_wp_target_group_arn" {}

#aws lb listener HTTPS
variable "elb_wp_https_listener_protocol" {}
variable "elb_wp_https_listener_port" {}
