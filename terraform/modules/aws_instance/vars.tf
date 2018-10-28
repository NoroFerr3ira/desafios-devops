variable "owner_alias" {
  description = "Dono da AMI que será usada."
}

variable "ami_name" {
  description = "Nome daAMI base usada para criação da instância EC2."
}

variable "instance_type" {
  description = "Tipo de hardware usado."
}

variable "subnet_id" {
  description = "ID da subnet em que a instância EC2 será criada."
}

variable "key_name" {
  description = "Key pair utilizada para acesso SSH."
}

variable "instance_sg" {
  description = "Security group utilizado para controlar as regras de firewall da instância EC2."
  type        = "list"
}

variable "user_data" {
  description = "User data usado para instalações no momento da criação da instância EC2."
}

variable "instance_root_volume_size" {
  description = "Tamanho do root volume da instância EC2 em GB."
}

variable "environment" {
  description = "Ambiente em que a máquina será criada (dev/prd)."
}
