FROM alpine:3.13

ENV KUBECTL_VERSION 1.20.2

WORKDIR /

# Enable SSL, helm plugins require git, helm-diff requires bash, curl
RUN apk --update add \
      ca-certificates \
      curl \
      tar \
      openssl \
      openssh \
      git \
      bash \
      jq

# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# install helm
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Plugin is downloaded to /tmp, which must exist
RUN helm plugin install https://github.com/viglesiasce/helm-gcs.git
RUN helm plugin install https://github.com/databus23/helm-diff

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY setup.sh /user/local/bin/setup.sh
RUN chmod u+x /user/local/bin/setup.sh

ENTRYPOINT [ "/user/local/bin/setup.sh" ]
