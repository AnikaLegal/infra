# Bookstack Wiki

Wiki used for Anika Legal course documenation. Hosted in AWS EC2.

- Domain: wiki.anikalegal.com
- IP: 3.24.123.148
- Private key: clerk.pem

[Bookstack Documentation](https://www.bookstackapp.com/docs/)

There is a MySQL database backing the app and a Apache2 webserver hosting it. Files are stored in S3 in `anika-bookstack`.

Error logs are written to `/var/www/bookstack/storage/logs/laravel.log`

## Config

Config is stored at `/var/www/bookstack/.env`. You need to ensure the following config is set manually:

```bash

APP_URL=https://wiki.anikalegal.com

# Ensure app can send invite emails
MAIL_DRIVER=smtp
MAIL_FROM=noreply@anikalegal.com
MAIL_HOST=smtp.sendgrid.net
MAIL_PORT=587
MAIL_ENCRYPTION=tls
MAIL_USERNAME=apikey
MAIL_PASSWORD=SG.**********

# Ensure app stores uploaded files in S3, not locally
# https://www.bookstackapp.com/docs/admin/upload-config/
STORAGE_TYPE=s3
STORAGE_S3_KEY=AKIA**********
STORAGE_S3_SECRET=**********
STORAGE_S3_BUCKET=anika-bookstack
STORAGE_S3_REGION=ap-southeast-2

# Allow Google logon
# https://www.bookstackapp.com/docs/admin/third-party-auth/#google
GOOGLE_APP_ID=**********
GOOGLE_APP_SECRET=**********

```

## Scripts

Setup wiki: do not run end-to-end. Just copy-paste fragments into a terminal.

```
./scripts/setup.sh
```

Backup database to S3 bucket:

```
./scripts/backup-db.sh
```

Restore database from latest backup in the S3 bucket:

```
./scripts/restore-db.sh
```

## Database backups

Currently, backups can be taken manually.

TODO: Add scheduled backups to S3.
