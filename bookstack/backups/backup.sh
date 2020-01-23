set -e

#!/bin/bash
# Take database backups for the BookStack MySQL database
HOST=XXXXXXXXXXXXXXXXX
S3_BUCKET=s3://anika-database-backups
TIME=$(date "+%s")
BACKUP_FILE="mysql_bookstack_${TIME}.sql.gz"
BACKUP_LOCAL="$BACKUP_DIR/$BACKUP_FILE"
BACKUP_S3="$S3_BUCKET/$BACKUP_FILE"
ssh ubuntu@$HOST /bin/bash << EOF
    set -e
    export PGHOST=localhost
    export PGDATABASE=$DATABASE_NAME
    echo "Creating local database dump $BACKUP_FILE"
    sudo mysqldump --all-databases | gzip > $BACKUP_FILE



EOF

# echo "Copying local dump to S3 - $BACKUP_S3"
# aws s3 cp $BACKUP_LOCAL $BACKUP_S3

# echo "Latest S3 backup:"
# aws s3 ls $S3_BUCKET | sort | tail -n 1