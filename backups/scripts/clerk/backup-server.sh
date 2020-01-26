#!/bin/bash
# Run this from the server.
# Assumes AWS permissions available for CLI
# Take database backups for the clerk database
set -e
cd /srv/backups/
. env/bin/activate
touch clerk.log

DATABASE_NAME=clerk
TIME=$(date "+%s")
S3_BUCKET=s3://anika-database-backups
BACKUP_FILE="postgres_${DATABASE_NAME}_${TIME}.sql.gz"
BACKUP_S3="$S3_BUCKET/$BACKUP_FILE"
export PGHOST=localhost
export PGDATABASE=$DATABASE_NAME

echo "$TIME Creating local database dump $BACKUP_FILE" >> clerk.log
pg_dump --format=custom | gzip > $BACKUP_FILE

echo "$TIME Copying local dump to S3 - $BACKUP_S3" >> clerk.log
aws s3 cp $BACKUP_FILE $BACKUP_S3

BACKUP_RESULT=$(aws s3 ls $S3_BUCKET | sort | grep clerk | tail -n 1)
echo "$TIME Latest S3 backup: $BACKUP_RESULT" >> clerk.log
