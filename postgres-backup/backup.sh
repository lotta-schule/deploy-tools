DUMP_FILE_NAME="postgres_backup_`date +%Y-%m-%d`.dump"
echo "Creating dump: $DUMP_FILE_NAME"

pg_dump --no-password --format=c --blobs > $DUMP_FILE_NAME

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  echo "Back up not created, check db connection settings"
  exit 1
fi

echo 'Successfully Backed Up'

s3cmd --host=${HOSTNAME} --host-bucket=${HOST_BUCKET} put $DUMP_FILE_NAME $@/$DUMP_FILE_NAME

exit 0