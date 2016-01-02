#!/bin/sh


## Move to backup folder
cd /backup

## Dump database
mysqldump -uroot -pPASSWORD --opt DATABASE_NAME > DATABASE_NAME.sql

## ZIP
tar -zcf MYSQL_$(date +%Y%m%d).tgz *.sql

## Delete history files (5 days)
#find -name '*.tgz' -type f -mtime +5 -exec rm -f {} \;

## Send Mail
#SUBJECT="Back Up MySql "$(date +%Y-%m-%d)
#TEXT="Backup databases:\n"$(/bin/ls *.sql)
#echo -e $TEXT | mail -s "SUBJECT" root

## Delete temp files
rm -f *.sql

