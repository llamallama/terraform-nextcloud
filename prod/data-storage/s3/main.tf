provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "s3" {
  #source = "../../../../terraform-modules/s3"
  source = "git::git@github.com:llamallama/terraform-modules.git//s3?ref=v0.1.0"

  bucket = "${var.environment}-nextcloud-bucket-chris"
  name = "Nextcloud ${var.environment}"
  environment = "${var.environment}"
}
