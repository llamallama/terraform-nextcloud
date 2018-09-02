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
    key = "nextcloud/${var.environment}/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/${var.environment}/iam/terraform.tfstate"
  }
}

data "terraform_remote_state" "nextcloud-backend" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/${var.environment}/services/nextcloud-backend/terraform.tfstate"
  }
}

data "terraform_remote_state" "efs" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/${var.environment}/data-storage/efs/terraform.tfstate"
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/global/data-storage/s3/terraform.tfstate"
  }
}

module "frontend" {
  source = "git::git@github.com:llamallama/terraform-modules.git//nextcloud-app?ref=v0.1.3"
  #source = "../../../../terraform-modules/nextcloud-app"
  environment = "${var.environment}"
  count_num = "${var.count_num}"
  ami = "${var.ami}"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_ids = "${data.terraform_remote_state.vpc.public_subnet_ids}"
  security_groups = "${data.terraform_remote_state.vpc.default_security_group_id}"
  iam_instance_profile = "${data.terraform_remote_state.iam.iam_instance_profile}"
  efs_mount_target = "${data.terraform_remote_state.efs.dns_name}"
  config_bucket = "${data.terraform_remote_state.s3.bucket_name}"

  nextcloud_url = "${var.nextcloud_url}"
  domain_name = "${var.domain_name}"
  access_ip = "${var.access_ip}"

  tags = {
    "Name" = "Nextcloud"
    "Environment" = "${var.environment}"
    "scheduler:ec2-startstop" = "default"
  }
}

resource "aws_lb_target_group_attachment" "nextcloud-tg-attachment" {
  count = "${var.count_num}"
  target_group_arn = "${data.terraform_remote_state.nextcloud-backend.tg_arn}"
  target_id        = "${module.frontend.instance_id[count.index]}"
  port             = 80
  
  lifecycle {
    create_before_destroy = true
  }
}
