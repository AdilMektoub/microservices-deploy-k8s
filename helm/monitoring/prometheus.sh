#!/bin/bash


echo "[1]: Add repo"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo "[2]: Update repo"
helm repo update

echo "[3]: install repos"
helm install prometheus prometheus-community/prometheus

echo "[4]: create service to expose prometheus"
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext
echo "service/prometheus-server-ext exposed"

echo "[5]: hosts"
kubectl get service
minikube service prometheus-server-ext