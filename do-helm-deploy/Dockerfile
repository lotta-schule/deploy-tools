FROM alpine:3.13

ENV KUBECTL_VERSION 1.20.2
ENV DOCTL_VERSION 1.55.0

WORKDIR /

# Enable SSL, helm plugins require git, helm-diff requires bash, curl
RUN apk --update add \
      ca-certificates \
      curl \
      tar \
      openssl \
      openssh \
      git \
      bash

# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install envsubst [better than using 'sed' for yaml substitutions]
ENV BUILD_DEPS="gettext"  \
    RUNTIME_DEPS="libintl"

RUN set -x && \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN cd /usr/local/bin && \
    curl -sL https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz | tar -xz

COPY setup.sh /user/local/bin/setup.sh
RUN chmod u+x /user/local/bin/setup.sh

ENTRYPOINT [ "/user/local/bin/setup.sh" ]
