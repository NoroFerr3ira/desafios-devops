
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_vpc_id | ID da VPC em que esse security group será criado. | string | - | yes |
| cidr_blocks | Range de IP que será permitido no security group. | string | - | yes |
| environment | Ambiente em que o security group será criado (dev/prd). | string | - | yes |
| http_https_sg_description | Descrição do security group. | string | - | yes |
| http_https_sg_name | Nome que será dado para o security group criado. | string | - | yes |
| http_port | Porta HTTP que será liberada. | string | - | yes |
| https_port | Porta HTTPs que será liberada. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id |  |

