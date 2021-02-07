# lotta/ionos-helm-deploy

Docker image to deploy on a IONOS Managed kubernetes cluster with helm.

https://hub.docker.com/r/lotta/ionos-helm-deploy

## Usage

Run the docker image with env variables IONOS_USER_NAME, IONOS_USER_PASSWORD and CLUSTER_ID as arguments:

```
docker run --rm -e IONOS_USER_NAME=<user_name> -e IONOS_USER_PASSWORD=<user_password> -e CLUSTER_ID=<cluster_id> lotta/ionos-helm-deploy
```

### Use to deploy via gitlab

We use the image to easily deploy via Gitlab-CI. Somehow the gitlab runner does not seem to respect the entrypoint.
We ended up doing this:

```yaml
# You could build and push to docker registry in another step
# Set IONOS_USER_NAME, IONOS_USER_PASSWORD and CLUSTER_ID in gitlab CI/CD settings

deploy:
  stage: deploy
  image:
    name: lotta/ionos-helm-deploy:latest
  script:
    - /user/local/bin/setup.sh # gitlab does not respect entrypoint, so manually call setup.sh
    - helm repo add lotta https://my-chart-repository
    - helm repo update
    - helm upgrade --install my-app lotta/my-app --wait --set image.tag=${CI_COMMIT_SHA} --set something.that=$THIS_IS_SECRET
```
