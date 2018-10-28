resource "aws_security_group" "security_group" {
  name        = "${var.ssh_sg_name}-${var.environment}"
  description = "${var.ssh_sg_description}"
  vpc_id      = "${var.aws_vpc_id}"

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "TCP"
    cidr_blocks = ["${var.your_cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}"
  }
}
