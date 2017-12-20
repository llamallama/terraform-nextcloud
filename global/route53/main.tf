provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

data "terraform_remote_state" "staging_nextcloud_backend" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/staging/services/nextcloud-backend/terraform.tfstate"
  }
}

resource "aws_route53_record" "staging_cloud" {
  zone_id = "${var.zone_id}"
  name = "staging-cloud.${var.domain}"
  type = "A"

  alias {
    name = "dualstack.${data.terraform_remote_state.staging_nextcloud_backend.dns_name}"
    zone_id = "${data.terraform_remote_state.staging_nextcloud_backend.zone_id}"
    evaluate_target_health = false
  }
}
