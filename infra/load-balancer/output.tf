output "elb_wp_dns_name" {
  value = aws_lb.elb_wordpress.dns_name
}

output "elb_wp_zone_id" {
  value = aws_lb.elb_wordpress.zone_id
}