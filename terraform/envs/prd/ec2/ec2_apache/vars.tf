variable "access_key" {}

variable "secret_key" {}

variable "region" {}

variable "owner_alias" {
  default = "amazon"
}

variable "ami_name" {
  default = "amzn2-ami-hvm*"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "aws_vpc_id" {}

variable "subnet_id" {}

variable "key_name" {}

variable "user_data" {
  default = <<EOF
  #!/usr/bin/env bash
  sudo /usr/bin/yum update -y
  sudo /usr/bin/yum install docker -y
  sudo chkconfig docker on
  sudo systemctl start docker
  sudo docker run --name apache -d -p 80:80 httpd
  EOF
}

variable "instance_root_volume_size" {
  default = "8"
}

variable "http_https_sg_name" {
  default = "http_https_sg"
}

variable "ssh_sg_name" {
  default = "ssh_sg"
}

variable "http_https_sg_description" {
  default = "SG para porta 80 e 443"
}

variable "ssh_sg_description" {
  default = "SG para porta 22"
}

variable "http_port" {
  default = "80"
}

variable "https_port" {
  default = "443"
}

variable "ssh_port" {
  default = "22"
}

variable "cidr_blocks" {
  default = "0.0.0.0/0"
}

variable "your_cidr_blocks" {}
