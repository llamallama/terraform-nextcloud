terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/route53/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
