provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "acm" {
  source = "../../../terraform-modules/acm"

  domain_name = "cloud.pipetogrep.org"
}
