variable "ssh_sg_name" {
  description = "Nome que será dado para o security group criado."
}

variable "ssh_sg_description" {
  description = "Descrição do security group."
}

variable "aws_vpc_id" {
  description = "ID da VPC em que esse security group será criado."
}

variable "ssh_port" {
  description = "Porta SSH que será liberada."
}

variable "your_cidr_blocks" {
  description = "Seu range de IP que será permitido no security group."
}

variable "environment" {
  description = "Ambiente em que o security group será criado (dev/prd)."
}
