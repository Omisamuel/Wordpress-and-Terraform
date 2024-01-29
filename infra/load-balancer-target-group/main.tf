resource "aws_lb_target_group" "alb_web_elb_tg" {
  name        = var.elb_wp_tg_project_name
#  target_type = var.elb_wp_tg_type
  port        = var.elb_wp_tg_port
  protocol    = var.elb_wp_tg_protocol
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    enabled             = true
    port = 80
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 60
    interval            = 200
    matcher             = "200"# has to be HTTP 200 or fails
  }

  lifecycle { create_before_destroy=true }
}


resource "aws_lb_target_group_attachment" "elb_wordpress_attachment" {
  target_group_arn = aws_lb_target_group.alb_web_elb_tg.arn
  target_id        = var.wordpress_web01_id
  port             = 80
}
