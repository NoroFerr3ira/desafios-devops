variable "http_https_sg_name" {
  description = "Nome que será dado para o security group criado."
}

variable "http_https_sg_description" {
  description = "Descrição do security group."
}

variable "aws_vpc_id" {
  description = "ID da VPC em que esse security group será criado."
}

variable "http_port" {
  description = "Porta HTTP que será liberada."
}

variable "https_port" {
  description = "Porta HTTPs que será liberada."
}

variable "cidr_blocks" {
  description = "Range de IP que será permitido no security group."
}

variable "environment" {
  description = "Ambiente em que o security group será criado (dev/prd)."
}
