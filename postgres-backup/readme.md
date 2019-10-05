# lotta/postgres-backup

Docker image to create a backup from a postgres database to a s3 compatible store

https://hub.docker.com/r/lotta/postgres-backup

## Usage

Run the docker image with following env variables:

|               |                             |                           |
|---------------| --------------------------- |---------------------:     |
|*postgres*       | PGHOST                      |database host              |
|               | PGDATABASE                  |database name              |
|               | PGUSER                      |database user              |
|               | PGPASSWORD                  |database password          |
|*c3cmd*         | AWS_ACCESS_KEY_ID           |AWS access key id          |
|               | AWS_SECRET_ACCESS_KEY       |AWS secret access key      |
|               | HOSTNAME                    |AWS compatible host        |
|               | HOST_BUCKET                 |AWS compatible host bucket |

see documentations for [pg_dump](https://www.postgresql.org/docs/12/app-pgdump.html) and [s3cmd](https://s3tools.org/usage) for more information

### Example:

```bash
docker run --rm \
    -e PGHOST=db.host.com \
    -e PGDATABASE=dbane \
    -e PGUSER=user \
    -e PGPASSWORD=password \
    -e AWS_ACCESS_KEY_ID=KEY_ID \
    -e AWS_SECRET_ACCESS_KEY=SECRET_KEY \
    -e HOSTNAME=fra1.digitaloceanspaces.com \
    -e HOST_BUCKET=='%(bucket)s.fra1.digitaloceanspaces.com' \
    lotta/postgres-backup /app/backup.sh s3://bucket/path
```
