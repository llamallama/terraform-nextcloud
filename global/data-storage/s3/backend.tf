terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/global/data-storage/s3/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
