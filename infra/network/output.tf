output "wp_vpc_eu_vpc_id" {
  value = aws_vpc.wp_vpc_eu.id
}

output "wp_public_subnets" {
  value = aws_subnet.wp_public_subnets.*.id
}

output "wp_private_subnets" {
  value = aws_subnet.wp_private_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.wp_public_subnets.*.cidr_block
}
