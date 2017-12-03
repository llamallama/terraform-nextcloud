provider "aws" {
  region = "us-east-1"
  profile = "chris"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/18"
  enable_dns_hostnames = true

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_route" "route" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
resource "aws_subnet" "public-1a" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_subnet" "public-1b" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1b"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
resource "aws_subnet" "public-1c" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1c"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Nextcloud ${var.environment_name} VPC"
  }
}
