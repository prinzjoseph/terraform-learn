provider "aws" {}

variable "cidr_name" {
    description = "cidr blocks and name"
    type = list(object({
        cidr_block = string,
        name = string
    }))
}

variable "avail_zone" {}

resource "aws_vpc" "dev-test" {
    cidr_block = var.cidr_name[0].cidr_block
    tags = {
        Name = var.cidr_name[0].name
    }
}

resource "aws_subnet" "dev_subnet" {
    vpc_id = "${aws_vpc.dev-test.id}"
    cidr_block = var.cidr_name[1].cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name = var.cidr_name[1].name
    }
} 

output "aws_vpc_id" {
    value = "${aws_vpc.dev-test.id}"  
}

output "aws_subnet_id" {
    value = "${aws_subnet.dev_subnet.id}"
}