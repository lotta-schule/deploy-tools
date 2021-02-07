# Deploy-Tools

This repository contains docker images meant to help deploying and doing backups

## Contents:

- [lotta/do-helm-deploy](./do-helm-deploy)
Base Image providing an environment with [helm](https://helm.sh/) and [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/), configured for [DigitalOcean](https://digitalocean.com/) environments.

- [lotta/ionos-helm-deploy](./ionos-helm-deploy)
Base Image providing an environment with [helm](https://helm.sh/) and [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/), configured for [Ionos](https://ionos.de/) environments.

- [lotta/postgres-backup](./ionos-helm-deploy)
Base Image providing [postgres](https://www.postgresql.org/docs/) and [s3cmd](https://github.com/s3tools/s3cmd), as well as some helper scripts for backup, transfer and restore.
