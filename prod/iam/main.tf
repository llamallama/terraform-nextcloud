provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

data "terraform_remote_state" "s3_configs" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/global/data-storage/s3/terraform.tfstate"
  }
}

data "terraform_remote_state" "s3_data" {
  backend = "s3"
  config {
    profile = "chris"
    region = "us-east-1"
    bucket = "chris-terraform-states"
    key = "nextcloud/${var.environment}/data-storage/s3/terraform.tfstate"
  }
}

module "ec2_role" {
  source = "git::git@github.com:llamallama/terraform-modules.git//iam//role?ref=v0.1.0"
  #source = "../../../terraform-modules/iam/role"
  effect = "Allow"
  name = "Nextcloud${var.environment}Ec2Role"
  service = "ec2.amazonaws.com"
}

module "ec2_role_policy" {
  source = "git::git@github.com:llamallama/terraform-modules.git//iam//role-policy?ref=v0.1.0"
  #source = "../../../terraform-modules/iam/role-policy"
  name = "Nextcloud${var.environment}Ec2RolePolicy"
  role = "${module.ec2_role.id}"
  effect = "Allow"
  resource = "${data.terraform_remote_state.s3_configs.arn}/${var.environment}/*"
  action = <<EOF
"s3:GetObject"
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name  = "Nextcloud${var.environment}InstanceProfile"
  role = "${module.ec2_role.name}"
}

resource "aws_iam_user" "nextcloud" {
  name = "Nextcloud${var.environment}"
}

resource "aws_iam_user_policy" "s3_data_policy" {
  name = "S3Nextcloud${var.environment}"
  user = "${aws_iam_user.nextcloud.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action":   [
                "s3:ListBucket"
            ],
            "Resource": [
                "${data.terraform_remote_state.s3_data.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "${data.terraform_remote_state.s3_data.arn}/*"
            ]
        }
    ]
}
EOF
}
