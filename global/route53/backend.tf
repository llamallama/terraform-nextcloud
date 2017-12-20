terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/global/route53/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
