data "aws_ami" "server_ami" {
most_recent = true
owners = ["amazon"]
filter {
name = "owner-alias"
values = ["amazon"]
}
filter {
name = "name"
values = ["amzn2-ami-hvm*-x86_64-gp2"]
}
}

resource "aws_instance" "terraabhi1" {
    count = var.instance_count[0]
    ami = data.aws_ami.server_ami.id
    instance_type = var.instance_type
    key_name = var.instance_key_name
    subnet_id = aws_subnet.network1test[0].id
    tags = {
        Name = "${var.cloud_env}_terraformtest23"
    }
}

resource "aws_vpc" "terratestvpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.cloud_env}_${var.vpc_tag_name}"
    }
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_subnet" "network1test" {
count = 2
vpc_id = aws_vpc.terratestvpc.id
cidr_block = count.index == 0 ? var.public_cidr[0] : var.private_cidr[0] 
map_public_ip_on_launch = count.index == 0
availability_zone = "us-east-1a"

tags = {
    Name = count.index == 0 ? "${var.cloud_env}_terratestsub_public" : "${var.cloud_env}_terratestsub_private"
}
}

resource "aws_internet_gateway" "tera-igw" {
  vpc_id = aws_vpc.terratestvpc.id

  tags = {
    Name = "${var.cloud_env}_tera-igw"
  }
}

resource "aws_default_route_table" "pvt_rout" {
  default_route_table_id = aws_vpc.terratestvpc.default_route_table_id

tags = {
    Name = "${var.cloud_env}_pvt_rout"
}
}

resource "aws_route_table" "pub_rout" {
    vpc_id = aws_vpc.terratestvpc.id

    tags = {
        Name = "${var.cloud_env}_pub_rout"
    }
}   

resource "aws_route" "terra_test_route" {
route_table_id = aws_route_table.pub_rout.id
destination_cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.tera-igw.id
}

resource "aws_security_group" "abhi_terra_sg" {
    name = "abhi_terra_sg"
    description = "Security group for all public Instances"
    vpc_id = aws_vpc.terratestvpc.id
}

resource "aws_security_group_rule" "ingress_all" {
    type = "ingress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = [aws_vpc.terratestvpc.cidr_block]
    security_group_id = aws_security_group.abhi_terra_sg.id
}


resource "aws_security_group_rule" "egress_all" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.abhi_terra_sg.id
}

