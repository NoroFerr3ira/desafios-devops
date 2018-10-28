
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami_name | Nome daAMI base usada para criação da instância EC2. | string | - | yes |
| environment | Ambiente em que a máquina será criada (dev/prd). | string | - | yes |
| instance_root_volume_size | Tamanho do root volume da instância EC2 em GB. | string | - | yes |
| instance_sg | Security group utilizado para controlar as regras de firewall da instância EC2. | list | - | yes |
| instance_type | Tipo de hardware usado. | string | - | yes |
| key_name | Key pair utilizada para acesso SSH. | string | - | yes |
| owner_alias | Dono da AMI que será usada. | string | - | yes |
| subnet_id | ID da subnet em que a instância EC2 será criada. | string | - | yes |
| user_data | User data usado para instalações no momento da criação da instância EC2. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws_instance_public_ip |  |

