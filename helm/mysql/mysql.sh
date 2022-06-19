#!/bin/bash

echo "[1]: Root Password"
kubectl create secret generic mysql-root-pass --from-literal=password=adil

echo "[2]: User Password"
kubectl create secret generic mysql-user-pass --from-literal=username=adilmektoub --from-literal=password=adil

echo "[3]: Database Url"
kubectl create secret generic mysql-db-url --from-literal=database=adilmektoub