#!/bin/bash
# Restore latest database backup to the BookStack MySQL database
# Run this from your local machine.
set -e
HOST=3.24.123.148
S3_BUCKET=s3://anika-database-backups

echo -e "\nLatest S3 backup:"
BACKUP_FILE=$(aws --profile anika s3 ls $S3_BUCKET | sort | grep bookstack | tail -n 1 | cut -d' ' -f8)
echo -e "\nFound backup file: $BACKUP_FILE"

echo -e "\nPulling $BACKUP_FILE from S3 $S3_BUCKET"
aws --profile anika s3 cp $S3_BUCKET/$BACKUP_FILE .

echo -e "\nCopying $BACKUP_FILE to server $HOST"
scp $BACKUP_FILE ubuntu@$HOST:/home/ubuntu/$BACKUP_FILE 
rm -f $BACKUP_FILE

echo -e "\nRestoring $BACKUP_FILE on server $HOST"
ssh ubuntu@$HOST /bin/bash << EOF
    set -e
    ls -la
    RESTORE_SCRIPT=$(echo "$BACKUP_FILE" | cut -d. -f1-2)
    rm -f \$RESTORE_SCRIPT
    gunzip $BACKUP_FILE

    DATABASE_EXISTS=\$(sudo mysqlshow | grep bookstack)
    if [[ -z "\$DATABASE_EXISTS" ]]
    then
        echo -e "\nBookstack database doesn't exist yet."
    else
        echo -e "\nDeleting Bookstack database..."
        echo "DROP DATABASE bookstack;" | sudo mysql
        echo "SHOW DATABASES;" | sudo mysql
    fi

    echo -e "\nRe-creating Bookstack database..."
    sudo mysqladmin create bookstack
    echo "SHOW DATABASES;" | sudo mysql

    echo -e "\nRestoring Bookstack database..."
    cat \$RESTORE_SCRIPT | sudo mysql
EOF
