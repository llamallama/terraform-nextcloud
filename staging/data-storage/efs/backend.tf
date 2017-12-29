terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/data-storage/efs/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
