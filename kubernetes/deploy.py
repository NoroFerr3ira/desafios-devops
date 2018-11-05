#!/usr/bin/env python
# -*- coding: utf-8 -*-

from kubernetes import client, config
import subprocess
import docker
import os

docker_api = docker.from_env()
docker_hub_user = '<COLOQUE SEU USUÁRIO DE UMA CONTA TESTE DO DOCKER HUB AQUI>'
docker_hub_password = '<COLOQUE A SENHA DO USUÁRIO DE UMA CONTA TESTE DO DOCKER HUB AQUI>'

# Docker Login - Docker Hub
print('======= Logando no docker hub =======')
docker_api.login(username=docker_hub_user, password=docker_hub_password)

# Diretórios utilizados para build e geração de versão do pacote
workdir = os.path.dirname(os.path.realpath(__file__))
appdir = (os.chdir(workdir + '/app'))

# Nome e tag de versão do pacote node
nametag = str('ferr3ira/idwall-app:' + subprocess.check_output(['npm', 'version', 'major'])).rstrip()

# Build da imagem do container de aplicação
print('======= Fazendo build da imagem ' + nametag + ' =======')
os.chdir(workdir)
docker_api.images.build(path=workdir, tag=nametag)

# Push da imagem do container para o Docker Hub
print('======= Publicando imagem ' + nametag + ' no Docker Hub =======')
docker_api.images.push(nametag)

deployment_name = 'idwall-deployment'
deployment_namespace = 'idwall-desafio-k8s'
print('======= Atualizando imagem do deployment ' + deployment_name + ' com a imagem: ' + nametag + ' =======')
config.load_kube_config()
api_instance = client.AppsV1beta1Api()
body = {"spec": {"replicas": 3, "revisionHistoryLimit": 10, "template": {"metadata": {"labels": {"app": "idwall-app"}}, "spec": {"containers": [{"name": "idwall-app", "image": nametag, "ports": [{"name": "nodejs-port", "containerPort": 3000}], "livenessProbe": {"httpGet": {"path": "/", "port": "nodejs-port"}, "initialDelaySeconds": 8, "timeoutSeconds": 5}}]}}}}
api_response = api_instance.patch_namespaced_deployment(deployment_name, deployment_namespace, body, pretty=True)
