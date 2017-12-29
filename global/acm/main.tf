provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "acm_prod" {
  source = "git::git@github.com:llamallama/terraform-modules.git//acm?ref=v0.0.8"
  #source = "../../../terraform-modules/acm"

  domain_name = "cloud.pipetogrep.org"
}

module "acm_staging" {
  source = "git::git@github.com:llamallama/terraform-modules.git//acm?ref=v0.0.8"
  #source = "../../../terraform-modules/acm"

  domain_name = "staging-cloud.pipetogrep.org"
}
