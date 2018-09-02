variable "ami" {
  default = "ami-db8d0ba4"
}
variable "nextcloud_url" {
  default = "https://download.nextcloud.com/server/releases/nextcloud-12.0.4.tar.bz2"
}
variable "domain_name" {
  default = "staging-cloud.piptogrep.org"
}
variable "access_ip" {
  default = "0.0.0.0/0"
}
variable "count_num" {
  default = "1"
}
variable "environment" {
  default = "staging"
}
