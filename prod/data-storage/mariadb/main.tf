provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/${var.environment}/vpc/terraform.tfstate"
  }
}

module "db" {
  #source = "../../../../terraform-modules/mariadb"
  source = "git::git@github.com:llamallama/terraform-modules.git//mariadb?ref=v0.1.0"

  identifier = "nextcloud${var.environment}db"

  engine            = "mariadb"
  engine_version    = "10.1.26"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"
  name     = "nextcloud"
  username = "nextcloud"
  password = "changeme"
  port     = "3306"


  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 5

  tags = {
    Owner       = "Chris"
    Environment = "${var.environment}"
  }

  db_subnet_group_name = "nextcloud db subnet group"
  subnet_ids = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]

  # DB parameter group
  parameter_group_name = "default.mariadb10.1"

  availability_zone = "us-east-1c"

}
