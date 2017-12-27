variable "region_number" {
  # Arbitrary mapping of region name to number to use in
  # a VPC's CIDR prefix.
  default = {
    us-east-1      = 10
    us-east-2      = 20
    us-west-1      = 30
    us-west-2      = 4
    eu-central-1   = 5
    eu-central-2   = 6
    ap-northeast-1 = 7
  }
}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {
  current = true
}

data "aws_availability_zone" "az" {
  count = "${length(data.aws_availability_zones.available.names)}"
  name  = "${data.aws_availability_zones.available.names[count.index]}"
}

variable "environment" {
  description = "Which environment does this belong to"
}

variable "vpc_name" {
    default = ""
}
locals {
  name_prefix = "${var.vpc_name != "" ? var.vpc_name : var.environment }"
}


resource "aws_vpc" "main" {
  cidr_block = "${cidrsubnet("10.0.0.0/8", var.region_newbits, var.region_number[data.aws_region.current.name])}"
  tags {
      Environment = "${var.environment}"
      Name = "${local.name_prefix}-vpc"
  }
}

resource "aws_subnet" "infra" {
  count      = "2"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, var.standard_subnet_newbits, count.index)}"

  tags {
    Name        = "infra-${element(data.aws_availability_zone.az.*.name_suffix, count.index)}"
    Tier        = "infra"
    Visibility  = "private"
    Environment = "${var.environment}"
  }
}

// kitchen terraform won't work without some outputs
// but these values are useful anyways, so it's not THAT
// hacky

output "subnet_ids" {
  value = "${aws_subnet.infra.*.id}"
}
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}