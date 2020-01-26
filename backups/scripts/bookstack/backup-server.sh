#!/bin/bash
# Run this from the server.
# Assumes AWS permissions available for CLI
# NOTE: This has to be manually set in /etc/environment
# Take database backups for the BookStack MySQL database
set -e
cd /srv/backups/
. env/bin/activate
touch bookstack.log

S3_BUCKET=s3://anika-database-backups
TIME=$(date "+%s")
BACKUP_FILE="mysql_bookstack_${TIME}.sql.gz"
BACKUP_S3="$S3_BUCKET/$BACKUP_FILE"

echo "$TIME Creating local database dump $BACKUP_FILE" >> bookstack.log
sudo mysqldump --all-databases | gzip > $BACKUP_FILE

echo "$TIME Copying local dump to S3 - $BACKUP_S3" >> bookstack.log
aws s3 cp $BACKUP_FILE $BACKUP_S3

BACKUP_RESULT=$(aws s3 ls $S3_BUCKET | sort | grep bookstack | tail -n 1)
echo "$TIME Latest S3 backup: $BACKUP_RESULT" >> bookstack.log
