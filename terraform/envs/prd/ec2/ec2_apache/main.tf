provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "constants" {
  source = "../../"
}

module "ec2_apache" {
  source = "../../../../modules/aws_instance"

  owner_alias               = "${var.owner_alias}"
  ami_name                  = "${var.ami_name}"
  instance_type             = "${var.instance_type}"
  subnet_id                 = "${var.subnet_id}"
  key_name                  = "${var.key_name}"
  instance_sg               = ["${module.ec2_apache_security_group_http_https.security_group_id}", "${module.ec2_apache_security_group_ssh.security_group_id}"]
  user_data                 = "${var.user_data}"
  instance_root_volume_size = "${var.instance_root_volume_size}"
  environment               = "${module.constants.environment}"
}

module "ec2_apache_security_group_http_https" {
  source = "../../../../modules/aws_security_group_http_https"

  http_https_sg_name        = "${var.http_https_sg_name}"
  http_https_sg_description = "${var.http_https_sg_description}"
  aws_vpc_id                = "${var.aws_vpc_id}"
  http_port                 = "${var.http_port}"
  https_port                = "${var.https_port}"
  cidr_blocks               = "${var.cidr_blocks}"
  environment               = "${module.constants.environment}"
}

module "ec2_apache_security_group_ssh" {
  source = "../../../../modules/aws_security_group_ssh"

  ssh_sg_name        = "${var.ssh_sg_name}"
  ssh_sg_description = "${var.ssh_sg_description}"
  aws_vpc_id         = "${var.aws_vpc_id}"
  ssh_port           = "${var.ssh_port}"
  your_cidr_blocks   = "${var.your_cidr_blocks}"
  environment        = "${module.constants.environment}"
}
