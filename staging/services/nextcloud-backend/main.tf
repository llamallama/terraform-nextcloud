provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/vpc/terraform.tfstate"
  }
}

module "lb" {
  source = "git::git@github.com:llamallama/terraform-modules.git//lb?ref=v0.0.8"
  #source = "../../../../terraform-modules/lb"

  lb_name = "NextcloudStaging"
  use_tls = 1
  certificate_arn = "arn:aws:acm:us-east-1:887110813782:certificate/8906e621-ee45-40b6-9ba7-7e31017d80ce"
  subnets = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  security_groups = "${data.terraform_remote_state.vpc.default_security_group_id}"
}
