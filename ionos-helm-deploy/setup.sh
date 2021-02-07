#!/bin/bash

if [ -z "$IONOS_USER_NAME" ]; then
    echo "\$IONOS_USER_NAME is not set."
    exit 1
fi
if [ -z "$IONOS_USER_PASSWORD" ]; then
    echo "\$IONOS_USER_PASSWORD is not set."
    exit 1
fi

if [ -z "$CLUSTER_ID" ]; then
    echo "\$CLUSTER_ID is not set."
    exit 1
fi

# fetch the kubeconfig
curl -O --user "$IONOS_USER_NAME:$IONOS_USER_PASSWORD" \
  -H "Content-Type=application/json" \
  "https://api.ionos.com/cloudapi/v5/k8s/$CLUSTER_ID/kubeconfig"

if [ "$(cat kubeconfig |jq -r '.type')" != "kubeconfig" ]; then
  echo "IONOS Api returned an error response:"
  cat kubeconfig
  exit 1
fi

mkdir $HOME/.kube
cat kubeconfig | jq -r '.properties.kubeconfig' > $HOME/.kube/config

echo "IONOS k8s cluster configured"

exec "$@"
