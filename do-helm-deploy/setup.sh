#!/bin/bash

if [ -z "$CLUSTER_NAME" ]; then
    echo "\$CLUSTER_NAME is not set."
    exit 1
fi

if [ -z "$DIGITALOCEAN_ACCESS_TOKEN" ]; then
    echo "\$DIGITALOCEAN_ACCESS_TOKEN is not set."
    exit 1
fi

doctl kubernetes cluster kubeconfig save $CLUSTER_NAME

echo "digitalocean k8s cluster configured"

exec "$@"