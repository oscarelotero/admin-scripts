# admin-scripts
Scripts for admin server


### Script _back_s3.sh_
Make a copy from workpath and upload to S3 using [**s3cmd**](https://github.com/s3tools/s3cmd)


### Script _pg_backup_rotate.sh_
Make a back up all databases from PostgreSQL, using **_pg_backup.config_** for configurations


### Script _upload_backupdb_s3.py_
Make a Zip file generated by _pg_backup_rotate.sh_ and upload to S3


>Set this files on crontab task
```
00 01 * * * /root/scripts/pg_backup_rotate.sh >> /var/log/cron-backup-server.log 2>&1
00 02 * * * /root/scripts/upload_backupdb_s3.py >> /var/log/cron-backup-server.log 2>&1
00 04 * * * /root/scripts/back_arqueonorte.sh >> /var/log/cron-backup-server.log 2>&1
```
