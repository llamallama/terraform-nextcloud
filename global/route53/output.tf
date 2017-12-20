output "staging_fqdn" {
  value = "${aws_route53_record.staging_cloud.fqdn}"
}
