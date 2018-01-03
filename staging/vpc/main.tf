provider "aws" {
  region = "us-east-1"
  profile = "chris"
}

module "vpc" {
  source = "git::git@github.com:llamallama/terraform-modules.git//vpc?ref=v0.1.0"
  #source = "../../../terraform-modules/vpc"

  environment = "${var.environment}"
  vpc_cidr = "172.16.0.0/16"
  public_1a_cidr = "172.16.0.0/24"
  public_1b_cidr = "172.16.1.0/24"
  public_1c_cidr = "172.16.2.0/24"
}
