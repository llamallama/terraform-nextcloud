output "prod_fqdn" {
  value = "${aws_route53_record.record.fqdn}"
}
