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

module "efs" {
  #source = "../../../../terraform-modules/efs"
  source = "git::git@github.com:llamallama/terraform-modules.git//efs?ref=v0.1.0"
  creation_token = "nextcloud_${var.environment}"
  name = "nextcloud_${var.environment}"
  num_mount_targets = 3
  subnet_ids = "${data.terraform_remote_state.vpc.public_subnet_ids}"
}
