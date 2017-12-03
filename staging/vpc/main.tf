provider "aws" {
  region = "us-east-1"
  profile = "chris"
}

resource "aws_vpc" "stage" {
  cidr_block = "10.0.0.0/18"
  tags {
    Name = "Nextcloud Staging"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.stage.id}"

  tags {
    Name = "Nextcloud Staging"
  }
}
resource "aws_route" "r" {
  route_table_id         = "${aws_vpc.stage.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
resource "aws_subnet" "public-1a" {
    vpc_id = "${aws_vpc.stage.id}"
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/24"
    tags {
      Name = "Nextcloud Staging"
    }
}
resource "aws_subnet" "public-1b" {
    vpc_id = "${aws_vpc.stage.id}"
    availability_zone = "us-east-1b"
    cidr_block = "10.0.1.0/24"
    tags {
      Name = "Nextcloud Staging"
    }
}
resource "aws_subnet" "public-1c" {
    vpc_id = "${aws_vpc.stage.id}"
    availability_zone = "us-east-1c"
    cidr_block = "10.0.2.0/24"
    tags {
      Name = "Nextcloud Staging"
    }
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
