output "aws_instance_public_ip" {
  value = "${module.ec2_apache.aws_instance_public_ip}"
}
