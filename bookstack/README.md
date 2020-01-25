# Bookstack Wiki

Wiki used for Anika Legal course documenation. Hosted in AWS EC2.

- Domain: wiki.anikalegal.com
- IP: 3.24.123.148
- Private key: clerk.pem

[Bookstack Documentation](https://www.bookstackapp.com/docs/)

There is a MySQL database backing the app and a Apache2 webserver hosting it. Files are stored in S3 in `anika-bookstack`.

Error logs are written to `/var/www/bookstack/storage/logs/laravel.log`

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
