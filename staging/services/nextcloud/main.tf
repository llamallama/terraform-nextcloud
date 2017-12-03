data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/vpc/terraform.tfstate"
  }
}
module "frontend" {
  source = "git::git@github.com:llamallama/terraform-modules.git//nextcloud-app?ref=v0.0.1"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_id = "${data.terraform_remote_state.vpc.public_subnet_1a}"

  nextcloud_url = "https://download.nextcloud.com/server/releases/nextcloud-12.0.3.tar.bz2"
}
output "public_id" {
  value = "${module.frontend.public_ip}"
}
output "address" {
  value = "${module.frontend.address}"
}
