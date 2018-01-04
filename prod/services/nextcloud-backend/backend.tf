terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/prod/services/nextcloud-backend/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
