output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
output "default_security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}
output "public_subnet_1a" {
  value = "${module.vpc.public_subnet_1a}"
}
output "public_subnet_1b" {
  value = "${module.vpc.public_subnet_1b}"
}
output "public_subnet_1c" {
  value = "${module.vpc.public_subnet_1c}"
}
output "public_subnet_ids" {
  value = [
    "${module.vpc.public_subnet_1a}",
    "${module.vpc.public_subnet_1b}",
    "${module.vpc.public_subnet_1c}"
  ]
}
