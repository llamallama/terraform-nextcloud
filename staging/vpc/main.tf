provider "aws" {
  region = "us-east-1"
  profile = "chris"
}

module "vpc" {
  source = "git::git@github.com:llamallama/terraform-modules.git//vpc?ref=v0.0.2"

  environment_name = "Staging"
  vpc_cidr = "172.16.0.0/16"
  public_1a_cidr = "172.16.0.0/24"
  public_1b_cidr = "172.16.1.0/24"
  public_1c_cidr = "172.16.2.0/24"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
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
