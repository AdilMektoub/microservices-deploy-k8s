# Projet CLOUD Epitech

## Installation Windows
Installer Docker Desktop

## Variables d'Environnements
* Copier le .env.example et coller dans le dossier "Project", puis le renommer en .env
* Remplir les informations nécessaires dans le .env

## Lancer les conteneurs
* A partir du terminal, veillez bien à être dans le dossier "projet".
* Lancer les conteneurs:
```
docker-compose up --build -d
```

## Configuration (à faire qu'une seule fois)
* Lorsque les conteneurs sont tous bien lancés, il faut importer les tables dans la base de données:
```
docker exec -it fpm /bin/bash
```
* Félicitation, vous êtes dans le conteneur du server Laravel appelé fpm. Voici la prochaine commande pour importer les tables dans la base de données:
```
php artisan migrate
```

## Liens dispo après lancement des conteneurs
* [Frontend](http://localhost/)
* [Backend](http://localhost:8000/)
* [RabbitMQ](http://localhost:15672)

## Helm charts
* Installer Helm
```
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```
* Attention vous devez deployer tout dans chaque namespace!
* Pour deployer dans le cluster k8s Mysql, RabbitMQ et Redis on utilise l'artifactorie de Bitnami
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install Mysql bitnami/mysql
helm install --name mysql --set mysqlRootPassword=rootpassword,mysqlUser=mysql,mysqlPassword=my-password,mysqlDatabase=mydatabase,persistence.existingClaim=mysql-pvc stable/mysql
helm install RabbitMQ bitnami/RabbitMQ
helm install Redis bitnami/Redis
```
* Pour deployer dans le cluster k8s Elasticsearch on utilise l'artifactorie de elasticsearch
```
helm repo add elastic https://helm.elastic.co
helm install my-elasticsearch elastic/elasticsearch --version 7.17.3
```
* Pour deployer dans le cluster k8s le front et back (fpm) en prod, qa et dev
```
helm install -f values.yaml -f secrets.yaml -n prod
helm install -f values-qa.yaml -f secrets.yaml -n qa
helm install -f values-dev.yaml -f secrets.yaml -n dev
```
* Pour deployer dans le cluster k8s le Monitoring en Deamonset (sur chaque noeuds)
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus_latest prometheus-community/kube-prometheus-stack
```

## GitOps avec ArgoCD
* Installation d'Argocd
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.0/manifests/install.yaml
```
* Pour acceder a la UI
```
kubectl -n argocd edit svc argocd-server
```
* Et changer dans spec => Type: (de ClusterIP a NodePort)
* [argocd](http://ip-node:31786)

## Certificat SSL
* Cert-Manager
```
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm install cert-manager --version v0.15.0 --namespace cert-manager jetstack/cert-manager
```



