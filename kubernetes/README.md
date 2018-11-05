# Desafio 02: Kubernetes

## Motivação

Kubernetes atualmente é a principal ferramenta de orquestração e _deployment_ de _containers_ utilizado no mundo, práticamente tornando-se um padrão para abstração de recursos de infraestrutura. 

Na IDWall todos nossos serviços são containerizados e distribuídos em _clusters_ para cada ambiente, sendo assim é importante que as aplicações sejam adaptáveis para cada ambiente e haja controle via código dos recursos kubernetes através de seus manifestos. 

## Objetivo
Dentro deste repositório existe um subdiretório **app** e um **Dockerfile** que constrói essa imagem, seu objetivo é:

- Construir a imagem docker da aplicação
    - Imagem da aplicação foi "buildada" e está presente no meu docker hub https://hub.docker.com/r/ferr3ira/idwall-app/
- Criar os manifestos de recursos kubernetes para rodar a aplicação (_deployments, services, ingresses, configmap_ e qualquer outro que você considere necessário)
    - Os manifestos para _deployments, services, ingress e namespace_ foram criados e estão presentes no meu fork na pasta **manifests**.
- Criar um _script_ para a execução do _deploy_ em uma única execução.
    - Tomei a liberdade de criar um script em python, esse script faz build da imagem da aplicação e aplica a tag de versão da aplicação, faz commit da imagem numa conta do docker hub que você define no script e em seguida faz deploy no minikube da nova versão (isso no meu deployment criado pelo manifesto aqui versionado).  
- A aplicação deve ter seu _deploy_ realizado com uma única linha de comando em um cluster kubernetes **local**
    - Para execução do deploy via kubectl utilizar: kubectl set image deployment/idwall-deployment idwall-app=ferr3ira/idwall-app:<TAG QUE DESEJA FAZER DEPLOY> -n idwall-desafio-k8s 
- Todos os _pods_ devem estar rodando
- A aplicação deve responder à uma URL específica configurada no _ingress_
    - No ingress presente nos manifestos criei um host chamado **app.idwall.co** para responder pela aplicação, para testar você pode criar em seu **/etc/hosts** uma entrada de DNS local apontando para o IP do seu minikube ou então você pode utilizar o curl alterando o valor do host no cabeçalho da requisição.

#### OBS. para utilizar o script de deploy.py você deve instalar via pip os clients **kubernetes** e **docker**
No seu terminal:
```pip install docker``` e ```pip install kubernetes```
    


## Extras 
- Utilizar Helm [HELM](https://helm.sh)
- Divisão de recursos por _namespaces_
    - O componentes deployments, services e ingress foram criados dentro do namespace **idwall-desafio-k8s**
- Utilização de _health check_ na aplicação
    - O deployment foi criado com o **livenessProbe** configurado
- Fazer com que a aplicação exiba seu nome ao invés de **"Olá, candidato!"**
    - Alterei o arquivo app.js para criar uma variável de ambiente com o meu nome 

## Notas

* Pode se utilizar o [Minikube](https://github.com/kubernetes/minikube) ou [Docker for Mac/Windows](https://docs.docker.com/docker-for-mac/) para execução do desafio e realização de testes.

* A aplicação sobe por _default_ utilizando a porta **3000** e utiliza uma variável de ambiente **$NAME**

* Não é necessário realizar o _upload_ da imagem Docker para um registro público, você pode construir a imagem localmente e utilizá-la diretamente.