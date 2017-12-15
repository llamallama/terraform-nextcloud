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

data "terraform_remote_state" "iam" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/iam/terraform.tfstate"
  }
}

data "terraform_remote_state" "nextcloud-backend" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/services/nextcloud-backend/terraform.tfstate"
  }
}

module "frontend" {
  #source = "git::git@github.com:llamallama/terraform-modules.git//nextcloud-app?ref=v0.0.3"
  source = "../../../../terraform-modules/nextcloud-app"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_id = "${data.terraform_remote_state.vpc.public_subnet_1a}"
  security_groups = "${data.terraform_remote_state.vpc.default_security_group_id}"
  iam_instance_profile = "${data.terraform_remote_state.iam.iam_instance_profile}"

  nextcloud_url = "https://download.nextcloud.com/server/releases/nextcloud-12.0.3.tar.bz2"
  domain_name = "test.pipetogrep.org"
}

resource "aws_lb_target_group_attachment" "nextcloud-tg-attachment" {
  target_group_arn = "${data.terraform_remote_state.nextcloud-backend.tg_arn}"
  target_id        = "${module.frontend.instance_id}"
  port             = 80
}
