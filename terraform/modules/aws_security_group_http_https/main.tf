resource "aws_security_group" "security_group" {
  name        = "${var.http_https_sg_name}-${var.environment}"
  description = "${var.http_https_sg_description}"
  vpc_id      = "${var.aws_vpc_id}"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_blocks}"]
  }

  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_blocks}"]
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
