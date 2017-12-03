module "frontend" {
  source = "../../../modules/nextcloud-app"

  nextcloud_url = "https://download.nextcloud.com/server/releases/nextcloud-12.0.3.tar.bz2"
}
output "public_id" {
  value = "${module.frontend.public_ip}"
}
output "address" {
  value = "${module.frontend.address}"
}
