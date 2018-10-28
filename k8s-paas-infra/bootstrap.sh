#!/bin/sh


ISTIO_PATH=./istio-1.0.3

# setup service accounts
kubectl apply -f service_account.yaml

kubectl create clusterrolebinding cluster-admin-binding \
 --clusterrole=cluster-admin \
 --user=$(gcloud config get-value core/account)

# install istio

kubectl apply -f ${ISTIO_PATH}/install/kubernetes/helm/istio/templates/crds.yaml
kubectl apply -f ${ISTIO_PATH}/install/kubernetes/istio-demo.yaml

# install jenkins-x
# jx install --provider kubernetes