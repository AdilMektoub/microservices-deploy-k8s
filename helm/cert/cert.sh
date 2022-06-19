#!/bin/bash

echo "[1]: Let’s Encrypt"
kubectl create -f ingress.yml
kubectl create -f production_issuer.yml

echo "[2]: Type loadbalancer"
kubectl get service nginx-ingress-controller

echo "[3]: Check"
kubectl get services -w