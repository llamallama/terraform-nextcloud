output "staging_iam_instance_profile" {
  value = "${aws_iam_instance_profile.staging_instance_profile.name}"
}
output "prod_iam_instance_profile" {
  value = "${aws_iam_instance_profile.prod_instance_profile.name}"
}
