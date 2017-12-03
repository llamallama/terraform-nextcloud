terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/vpc/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

