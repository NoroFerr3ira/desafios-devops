data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["${var.owner_alias}"]
  }

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }
}

resource "aws_instance" "instance" {
  ami             = "${data.aws_ami.ami.id}"
  instance_type   = "${var.instance_type}"
  subnet_id       = "${var.subnet_id}"
  key_name        = "${var.key_name}"
  security_groups = ["${var.instance_sg}"]
  user_data       = "${var.user_data}"

  root_block_device {
    volume_size = "${var.instance_root_volume_size}"
  }

  tags {
    Name = "ec2-${var.environment}-apache"
  }
}
