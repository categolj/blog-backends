#!/bin/bash
set -e

NAMESPACE=$1
SERVICE_ACCOUNT=$2

SECRET_NAME=`kubectl get serviceaccount ${SERVICE_ACCOUNT} -n ${NAMESPACE} -o 'jsonpath={.secrets[0].name}'`
TOKEN=`kubectl get secret ${SECRET_NAME} -n ${NAMESPACE} -o 'jsonpath={.data.token}' | base64 --decode`
CREDENTIALS_NAME="${NAMESPACE}:${SERVICE_ACCOUNT}"
kubectl config set-credentials ${CREDENTIALS_NAME} --token=${TOKEN} > /dev/null

CURRENT_CLUSTER=`kubectl config view --minify=true -o jsonpath='{.clusters[0].name}'`
CONTEXT_NAME="${CURRENT_CLUSTER}:${CREDENTIALS_NAME}"

kubectl config set-context ${CONTEXT_NAME} \
    --cluster=${CURRENT_CLUSTER} \
    --namespace=${NAMESPACE} \
    --user=${CREDENTIALS_NAME} > /dev/null

CURRENT_CONTEXT=`kubectl config current-context`
kubectl config use-context ${CONTEXT_NAME} > /dev/null
kubectl config view --minify=true --raw=true 
kubectl config use-context ${CURRENT_CONTEXT} > /dev/null
if [ "$3" != "--keep" ];then
  kubectl config delete-context ${CONTEXT_NAME} > /dev/null
  kubectl config unset "users.${CREDENTIALS_NAME}" > /dev/null
fi
