#!/bin/bash

WORK_PATH='/home/user/path/to/project'
BUCKET='s3://backup-bucket'
FOLDER='my-folder-backup'


echo "------------------------------------------------------------------"
echo "`date +\%Y-\%m-\%d` - Back Up Files upload to S3"
cd $WORK_PATH
s3cmd sync $FOLDER $BUCKET

