-------------------------------------------------------------------------------------------------

# Desafio 01: Infrastructure-as-code - Terraform

## Resolução

Tomei a liberdade para reescrever a README.md com informações sobre a minha resolução do teste + "how to" de como fazer uso dos módulos criados para o teste.

## Tópicos do teste:
- Criar uma instância **n1-standard-1** (GCP) ou **t2.micro** (AWS) Linux utilizando **Terraform**.
    - Para o teste optei utilizar a AWS para criação de uma instância **t2.micro**, criei um módulo chamado **aws_instance** responsável pela criação da instância EC2.
- A instância deve ter aberta somente às portas **80** e **443** para todos os endereços
    - Criei um módulo para o teste chamado **aws_security_group_http_https**, esse módulo cria um security group liberando as portas 80 e 443 para 0.0.0.0/0.
- A porta SSH (**22**) deve estar acessível somente para um _range_ IP definido.
    - Criei um módulo para o teste chamado **aws_security_group_http_https**, esse módulo cria um security group liberando a porta 22 para para um range ou IP definido no momento do `terraform apply`, ou seja IP ou _range_ necessário para a liberação da porta SSH é um **input**.

#### Inputs aceiros naexecução do projeto:
Além dos inputs solicitados no teste, tornei  necessário como input as variáveis que definem o **ID da VPC** e **ID da Subnet** e também a **key pair name**, dessa forma é utilizar esse projeto para criar máquinas em qualquer região da AWS.
Lista de inputs:
  - O IP ou _range_ necessário para a liberação da porta SSH;
  - A região da _cloud_ em que será provisionada a instância;
  - O ID da VPC que será utilizada para criação da instância EC2 e os security groups necessários;
  - O ID da Subnet que será utilizada para criação da instância EC2;
  - O nome da Key Pair utilizada para acesso a instância EC2 que será criada;

#### Outputs:
- Os módulo **aws_security_group_http_https** e **aws_security_group_ssh** geram o output chamado **security_group_id**;
- O módulo **aws_instance** gera um output chamado **aws_instance_public_ip** que responsável por imprimir o IP público da instância.

#### Extras
- Pré-instalar o docker na instância que suba automáticamente a imagem do [Apache](https://hub.docker.com/_/httpd/), tornando a página padrão da ferramenta visualizável ao acessar o IP público da instância
    - Para esse extra fiz uso do **user data** da instância EC2, então quando a máquina é criada é feito um `yum update` da instância e logo em seguida é instalado/habilitado no boot na instância o **docker**, em seguida o serviço instalado é iniciado e um container com a imagem **httpd** é criado e permitindo que todas as requisições da porta 80 da instância sejam redirecionadas para a porta 80 do container recém criado.
- Utilização de módulos do Terraform
    - Como já mencionei no decorrer desse README.md fiz a utilização de módulos para criação da instância e dos security groups, dessa forma tenho "templates" para os componentes na AWS, dessa forma evito a duplicação de código e se necessário a criação de um componente eu apenas faço a chamada do módulo passando suas variáveis/constântes necessárias.

#### Estrutura de diretórios
```
terraform/
├── credential.tvars-sample---------------> Arquivo para preenchimento das variáveis de acess_key e secret_key.
├── envs----------------------------------> Ambientes para segreção das chamadas de módulos.
│   ├── dev
│   └── prd
│       ├── constants.tf------------------> Arquivo com valores que são considerados constântes para o ambiente.
│       └── ec2---------------------------> Dentro dos ambientes posso segregar as minhas chamadas de módúlos por serviços. Ex: ec2, s3, vpc e etc.
│           └── ec2_apache----------------> Diretório com a chamada de módulo para serviço ec2, outputs e suas variáveis, nesse caso estou criando uma instância ec2 que será um servidor apache httpd.
│               ├── main.tf---------------> No arquivo main.tf é feita a chamada dos módulos aws_instance, aws_security_group_http_https e aws_security_group_ssh.
│               ├── outputs.tf------------> No arquivo de output eu faço a impressão do public IP da instância criada pela chamada de módulo aws_instance.
│               └── vars.tf---------------> Arqui são aplicadas todas as vairáveis para criação da instância e dos security groups. Variáveis vazias são solicitadas no momento da execução do terraform apply.
│
├── modules-------------------------------> Nesse diretório ficam todos os módulos utilizados pelo projeto.
│   │
│   ├── aws_instance----------------------> Módulo para a criação de instãncias ec2.
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   ├── aws_security_group_http_https-----> Módulo para a criação de security group que libera a porta 80 e 443 para 0.0.0.0/0.
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   └── vars.tf
│   └── aws_security_group_ssh------------> Módulo para a criação de security group que libera a porta 80 e 443 para range de IP ou IP passado como parâmetro no momento da execução do terraform. 
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       └── vars.tf
└── README.md`
```

#### Avisos
- Antes de tudo é necessário você preencher o arquivo `credential.tfvars-sample` colocando os valores de `acess key` e `secret key`. Lembre se de usar acess key e secret key com as devidas permissões para criação de instâncias EC2 e security groups;
- Mude o nome do arquivo `credential.tfvars-sample` para `credential.tfvars` **e coloque ele em um diretório que não seja do projeto por precaução (o arquivo se ecnontra no .gitignore, mas opto por não deixá-lo dentro do diretório do projeto)**.

#### Terraform apply
feito as especificações dadas no tópico de **aviso**, para execução do `terraform apply` execute o comando a seguir dentro do diretório `desafios-devops/terraform/envs/prd/ec2/ec2_apache`:

#### 1º

```
terraform get && terraform init
```
#### 2º
```
terraform apply -var-file=/path/para/arquivo/credential.tfvar 
```
Em seguida será solicitado no momento da execução o **input** das variáveis:
- **aws_vpc_id:** ID da VPC utilizado para a criação da VM;
- **key_name:** Key pair utilizada para acesso a instância EC2;
- **region:** Região em que a instância será criada;
- **subnet_id:** ID da subnet em que a instância ec2 será alocada;
- **your_cidr_blocks:** Range de IP ou IP que será permitido para acesso SSH na instância. Ex.: 172.168.35.0/32;

### Notas
- A VPC e subnet escolhida deveem ser da mesma região escolhida, assim como a key_pair também;
- A subnet utilizada deve pertencer a VPC utilizada;
- Após a criação da VM é necessário esperar alguns instântes para validação do acesso ao servidor apache recém criado pois demora alguns instântes após a criação da instância para a instalação do docker e criação do container com base na imagem apache httpd presente no docker hub, depois de alguns minutos ja será possível fazer requisições no IP do servidor recém criado.
