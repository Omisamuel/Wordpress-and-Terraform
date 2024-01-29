resource "aws_lb" "elb_wordpress" {
  name               = var.elb_project_name
  internal           = var.elb_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.sg_for_elb]
  subnets            = var.subnet_id

  enable_deletion_protection = false

  tags = {
    Environment = var.elb_name
  }
}

resource "aws_lb_target_group_attachment" "elb_wordpress_attachment" {
  target_group_arn = var.elb_wp_target_group_arn
  target_id        = var.wordpress_web01_id
  port             = var.elb_target_port
}

# create listener on port 80 with redirect action
resource "aws_lb_listener" "elb_wp_listener_http" {
  load_balancer_arn = aws_lb.elb_wordpress.arn
  port              = var.elb_wp_listener_port
  protocol          = var.elb_wp_listener_protocol

  default_action {
    type             = var.elb_wp_listener_default_action
    target_group_arn = var.elb_wp_target_group_arn
  }
}

# Forward action
resource "aws_lb_listener" "elb_wp_listener_https" {
  load_balancer_arn = aws_lb.elb_wordpress.arn
  port              = var.elb_wp_https_listener_port
  protocol          = var.elb_wp_https_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-2:333641116594:certificate/c3394995-da17-4827-8fde-f2f7955d582d"

  default_action {
    type             = var.elb_wp_listener_default_action
    target_group_arn = var.elb_wp_target_group_arn
  }
}