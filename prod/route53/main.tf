provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

data "terraform_remote_state" "nextcloud_backend" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/${var.environment}/services/nextcloud-backend/terraform.tfstate"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "${var.zone_id}"
  name = "${var.domain}"
  type = "A"

  alias {
    name = "dualstack.${data.terraform_remote_state.nextcloud_backend.dns_name}"
    zone_id = "${data.terraform_remote_state.nextcloud_backend.zone_id}"
    evaluate_target_health = false
  }
}
