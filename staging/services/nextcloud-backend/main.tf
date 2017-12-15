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
  #source = "git::git@github.com:llamallama/terraform-modules.git//lb?ref=v0.0.3"
  source = "../../../../terraform-modules/lb"

  lb_name = "NextcloudStaging"
  subnets = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"
}
