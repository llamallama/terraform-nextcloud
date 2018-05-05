variable "ami" {
  default = "ami-db8d0ba4"
}
variable "nextcloud_url" {
  default = "https://download.nextcloud.com/server/releases/nextcloud-12.0.4.tar.bz2"
}
variable "domain_name" {
  default = "prod-cloud.piptogrep.org"
}
variable "access_ip" {
  default = "69.202.249.68/32"
}
variable "count_num" {
  default = "1"
}
variable "environment" {
  default = "prod"
}
