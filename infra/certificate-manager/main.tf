resource "aws_acm_certificate" "wp_acm_arn" {
  domain_name       = var.domain_name
  validation_method = "EMAIL"

  tags = {
    Environment = "production"
  }
}

resource "aws_acm_certificate_validation" "wp_acm_arn" {
  certificate_arn         = aws_acm_certificate.wp_acm_arn.arn

  timeouts {
    create = "120m"
  }
}