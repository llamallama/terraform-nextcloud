provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "ec2Role" {
  source = "../../../terraform-modules/iam/role"
  effect = "Allow"
  name = "NextcloudStagingEC2Role"
  service = "ec2.amazonaws.com"
}

module "ec2RolePolicy" {
  source = "../../../terraform-modules/iam/role-policy"
  name = "NextcloudStagingEC2RolePolicy"
  role = "${module.ec2Role.id}"
  effect = "Allow"
  resource = "arn:aws:s3:::cloud.pipetogrep.org/staging/*"
  action = <<EOF
"s3:GetObject"
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name  = "NextcloudStagingInstanceProfile"
  role = "${module.ec2Role.name}"
}
