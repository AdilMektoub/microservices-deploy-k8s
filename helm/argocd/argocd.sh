#!/bin/bash


echo "[1]: install argocd"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.0/manifests/install.yaml

echo "[2]: change spec.type from ClusterIP to NodePort to access UI"
kubectl -n argocd edit svc argocd-server