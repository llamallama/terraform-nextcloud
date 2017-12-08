terraform {
  backend "s3" {
    profile = "chris"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/data-storage/mariadb/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
