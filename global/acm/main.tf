provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "acm_prod" {
  source = "../../../terraform-modules/acm"

  domain_name = "cloud.pipetogrep.org"
}

module "acm_staging" {
  source = "../../../terraform-modules/acm"

  domain_name = "cloud.pipetogrep.org"
}
