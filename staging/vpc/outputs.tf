output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnet_1a" {
  value = "${aws_subnet.public-1a.id}"
}
output "public_subnet_1b" {
  value = "${aws_subnet.public-1b.id}"
}
output "public_subnet_1c" {
  value = "${aws_subnet.public-1c.id}"
}
output "public_subnet_ids" {
  value = [
    "${aws_subnet.public-1a.id}",
    "${aws_subnet.public-1b.id}",
    "${aws_subnet.public-1c.id}"
  ]
}
output "igw_id" {
  value = [
    "${aws_internet_gateway.gw.id}"
  ]
}
