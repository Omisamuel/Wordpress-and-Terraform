#Output for certificate manager
output "wp_acm_arn" {
  value = aws_acm_certificate.wp_acm_arn.arn
}