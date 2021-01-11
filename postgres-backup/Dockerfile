FROM alpine

RUN mkdir -p /app
WORKDIR /app

COPY backup.sh /app
COPY restore.sh /app
RUN chmod +x backup.sh

RUN apk update
RUN apk add --no-cache \
    py-pip \
    ca-certificates \
    ca-certificates \
    curl \
    bash \
    postgresql
RUN pip install s3cmd

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/backup.sh" ]
