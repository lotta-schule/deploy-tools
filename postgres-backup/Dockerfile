FROM alpine

RUN mkdir -p /app
WORKDIR /app

COPY backup.sh /app
COPY restore.sh /app
RUN chmod +x backup.sh

RUN apk update
RUN apk add --no-cache \
    python3 \
    py-pip \
    py-setuptools \
    ca-certificates \
    libmagic \
    curl \
    bash \
    postgresql
RUN pip install python-dateutil python-magic

# install s3cmd
RUN export S3CMD_CURRENT_VERSION=`curl -fs https://api.github.com/repos/s3tools/s3cmd/releases/latest | grep tag_name | sed -E 's/.*"v?([0-9\.]+).*/\1/g'` && \
    echo downloading s3cmd v${S3CMD_CURRENT_VERSION} && \
    mkdir -p /opt && \
    wget https://github.com/s3tools/s3cmd/releases/download/v${S3CMD_CURRENT_VERSION}/s3cmd-${S3CMD_CURRENT_VERSION}.zip && \
    unzip s3cmd-${S3CMD_CURRENT_VERSION}.zip -d /opt/ && \
    ln -s $(find /opt/ -name s3cmd) /usr/bin/s3cmd && \
    ls /usr/bin/s3cmd

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/backup.sh" ]
