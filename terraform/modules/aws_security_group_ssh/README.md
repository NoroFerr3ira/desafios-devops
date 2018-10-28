
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_vpc_id | ID da VPC em que esse security group será criado. | string | - | yes |
| environment | Ambiente em que o security group será criado (dev/prd). | string | - | yes |
| ssh_port | Porta SSH que será liberada. | string | - | yes |
| ssh_sg_description | Descrição do security group. | string | - | yes |
| ssh_sg_name | Nome que será dado para o security group criado. | string | - | yes |
| your_cidr_blocks | Seu range de IP que será permitido no security group. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | ID do security group |

