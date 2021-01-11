DUMP_FILE_NAME="postgres_backup_`date +%Y-%m-%d`.dump"
echo "Creating dump: $DUMP_FILE_NAME"

PROPS="--no-password --format=c --blobs"
if [ $SCHEMANAME ]; then
  PROPS="$PROPS -n $SCHEMANAME"
fi
pg_dump $PROPS > $DUMP_FILE_NAME

echo "pg_dump $PROPS"

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  echo "Back up not created, check db connection settings"
  exit 1
fi

echo 'Successfully Backed Up'

s3cmd --host=${HOSTNAME} --host-bucket=${HOST_BUCKET} put $DUMP_FILE_NAME $@/$DUMP_FILE_NAME

exit 0
