provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "s3" {
  #source = "../../../terraform-modules/s3"
  source = "git::git@github.com:llamallama/terraform-modules.git//s3?ref=v0.1.0"

  bucket = "nextcloud-config-chris"
  name = "Nextcloud Configs"
  environment = "${var.environment}"
}
