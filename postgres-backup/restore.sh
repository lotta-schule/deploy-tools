DUMP_FILE_NAME="postgres_backup_`date +%Y-%m-%d`.dump"
echo "Getting dump: $DUMP_FILE_NAME"

s3cmd --host=${HOSTNAME} --host-bucket=${HOST_BUCKET} get $@/$DUMP_FILE_NAME

echo "pg_restore --clean --if-exists --no-password --verbose --no-acl --superuser=postgres --format=c -d lotta $DUMP_FILE_NAME"
pg_restore --clean --if-exists --no-password --verbose --no-acl --superuser=postgres --format=c -d lotta $DUMP_FILE_NAME

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  echo "Back up restored"
  exit 1
fi

echo 'Successfully Restored Backup'


exit 0
