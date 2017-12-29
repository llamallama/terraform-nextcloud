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
    key = "nextcloud/global/iam/terraform.tfstate"
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

data "terraform_remote_state" "s3" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/services/nextcloud-backend/terraform.tfstate"
  }
}

data "terraform_remote_state" "efs" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/data-storage/efs/terraform.tfstate"
  }
}

module "frontend" {
  source = "git::git@github.com:llamallama/terraform-modules.git//nextcloud-app?ref=v0.0.9"
  #source = "../../../../terraform-modules/nextcloud-app"
  count_num = "${var.count_num}"
  ami = "ami-ace3acd6"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_ids = "${data.terraform_remote_state.vpc.public_subnet_ids}"
  security_groups = "${data.terraform_remote_state.vpc.default_security_group_id}"
  iam_instance_profile = "${data.terraform_remote_state.iam.staging_iam_instance_profile}"
  efs_mount_target = "${data.terraform_remote_state.efs.dns_name}"
  environment = "${var.environment}"

  nextcloud_url = "${var.nextcloud_url}"
  domain_name = "${var.domain_name}"
  access_ip = "${var.access_ip}"
}

resource "aws_lb_target_group_attachment" "nextcloud-tg-attachment" {
  count = "${var.count_num}"
  target_group_arn = "${data.terraform_remote_state.nextcloud-backend.tg_arn}"
  target_id        = "${module.frontend.instance_id[count.index]}"
  port             = 80
}
