provider "aws" {
 region = "us-east-1"
 profile = "chris"
}

module "staging_ec2_role" {
  source = "git::git@github.com:llamallama/terraform-modules.git//iam//role?ref=v0.0.6"
  #source = "../../../terraform-modules/iam/role"
  effect = "Allow"
  name = "NextcloudStagingEc2Role"
  service = "ec2.amazonaws.com"
}

module "staging_ec2_role_policy" {
  source = "git::git@github.com:llamallama/terraform-modules.git//iam//role-policy?ref=v0.0.6"
  #source = "../../../terraform-modules/iam/role-policy"
  name = "NextcloudStagingEc2RolePolicy"
  role = "${module.staging_ec2_role.id}"
  effect = "Allow"
  resource = "arn:aws:s3:::cloud.pipetogrep.org/staging/*"
  action = <<EOF
"s3:GetObject"
EOF
}

resource "aws_iam_instance_profile" "staging_instance_profile" {
  name  = "NextcloudStagingInstanceProfile"
  role = "${module.staging_ec2_role.name}"
}

resource "aws_iam_user" "nextcloud_staging" {
  name = "NextcloudStaging"
}

resource "aws_iam_user_policy" "s3_nextcloud_staging" {
  name = "S3NextcloudStaging"
  user = "${aws_iam_user.nextcloud_staging.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::staging-cloud.pipetogrep.org"
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
                "arn:aws:s3:::staging-cloud.pipetogrep.org/*"
            ]
        }
    ]
}
EOF
}

module "prod_ec2_role" {
  source = "git::git@github.com:llamallama/terraform-modules.git//iam//role?ref=v0.0.6"
  #source = "../../../terraform-modules/iam/role"
  effect = "Allow"
  name = "NextcloudProdEc2Role"
  service = "ec2.amazonaws.com"
}

module "prod_ec2_role_policy" {
  source = "git::git@github.com:llamallama/terraform-modules.git//iam//role-policy?ref=v0.0.6"
  #source = "../../../terraform-modules/iam/role-policy"
  name = "NextcloudProdEc2RolePolicy"
  role = "${module.prod_ec2_role.id}"
  effect = "Allow"
  resource = "arn:aws:s3:::cloud.pipetogrep.org/prod/*"
  action = <<EOF
"s3:GetObject"
EOF
}

resource "aws_iam_instance_profile" "prod_instance_profile" {
  name  = "NextcloudProdInstanceProfile"
  role = "${module.prod_ec2_role.name}"
}

resource "aws_iam_user" "nextcloud_prod" {
  name = "NextcloudProd"
}

resource "aws_iam_user_policy" "s3_nextcloud_prod" {
  name = "S3NextcloudProd"
  user = "${aws_iam_user.nextcloud_prod.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::prod-cloud.pipetogrep.org"
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
                "arn:aws:s3:::prod-cloud.pipetogrep.org/*"
            ]
        }
    ]
}
EOF
}
