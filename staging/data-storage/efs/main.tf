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

module "efs" {
  source = "../../../../terraform-modules/efs"
  #source = "git::git@github.com:llamallama/terraform-modules.git//efs?ref=v0.0.8"
  creation_token = "nextcloud_staging"
  name = "nextcloud_staging"
  num_mount_targets = 3
  subnet_ids = "${data.terraform_remote_state.vpc.public_subnet_ids}"
}
