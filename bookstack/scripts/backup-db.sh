#!/bin/bash
# Take database backups for the BookStack MySQL database
set -e
HOST=3.24.123.148
S3_BUCKET=s3://anika-database-backups
TIME=$(date "+%s")
BACKUP_FILE="mysql_bookstack_${TIME}.sql.gz"
BACKUP_S3="$S3_BUCKET/$BACKUP_FILE"
ssh ubuntu@$HOST /bin/bash << EOF
    set -e
    export PGHOST=localhost
    export PGDATABASE=$DATABASE_NAME
    echo "Creating local database dump $BACKUP_FILE"
    sudo mysqldump --all-databases | gzip > $BACKUP_FILE
EOF

echo "Pulling $BACKUP_FILE"
scp ubuntu@$HOST:/home/ubuntu/$BACKUP_FILE .

echo "Copying local dump to S3 - $BACKUP_S3"
aws --profile anika s3 cp $BACKUP_FILE $BACKUP_S3

echo "Latest S3 backup:"
aws --profile anika s3 ls $S3_BUCKET | sort | grep bookstack | tail -n 1

rm -f $BACKUP_FILE
