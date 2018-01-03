# terraform-nextcloud

## Application Order

1. Global S3
  * Manually create the directories staging/config and prod/config
  * Manually upload a minimal Nextcloud config.php file
1. VPC
1. Environment S3
1. IAM
  * Manually create the IAM keys
1. mariadb
  * Manually change the master password
1. efs
1. nextcloud-backend
1. nextcloud-frontend
1. route53

After all that, configure Nextcloud and copy the new config.php contents to its appropriate location in the config S3 bucket
