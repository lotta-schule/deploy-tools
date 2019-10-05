# lotta/do-helm-deploy

Docker image to deploy on a digitalocean cluster with helm.

https://hub.docker.com/r/lotta/do-helm-deploy

## Usage

Run the docker image with env variables DIGITALOCEAN_ACCESS_TOKEN and CLUSTER_NAME as arguments:

```
docker run --rm -e DIGITALOCEAN_ACCESS_TOKEN=<access_token> -e CLUSTER_NAME=<cluster_name> lotta/do-helm-deploy
```

### Use to deploy via gitlab

We use the image to easily deploy via Gitlab-CI. Somehow the gitlab runner does not seem to respect the entrypoint.
We ended up doing this:

```yaml
# You could build and push to docker registry in another step
# Set DIGITALOCEAN_ACCESS_TOKEN and CLUSTER_NAME in gitlab CI/CD settings

deploy:
  stage: deploy
  image:
    name: lotta/do-helm-deploy:latest
  script:
    - /user/local/bin/setup.sh # gitlab does not respect entrypoint, so manually call setup.sh
    - helm repo add lotta https://my-chart-repository
    - helm repo update
    - helm upgrade --install my-app lotta/my-app --wait --set image.tag=${CI_COMMIT_SHA} --set something.that=$THIS_IS_SECRET
```