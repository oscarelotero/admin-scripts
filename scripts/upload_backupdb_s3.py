#!/usr/bin/python

import tinys3
import os
import zipfile
from datetime import datetime

BUCKET_NAME = 'backup-bucket'
S3_ACCESS_KEY ='S3_ACCESS_KEY'
S3_SECRET_KEY= 'S3_SECRET_KEY'
BASE_DIR = os.path.join(os.path.dirname(__file__), 'databases')
TODAY = datetime.now().strftime("%Y-%m-%d") + '-daily'
FOLDER = os.path.join(BASE_DIR, TODAY)
DAY_WEEK = datetime.today().weekday()
ZIP_NAME = os.path.join(BASE_DIR, 'db_backup_{0}.zip'.format(DAY_WEEK))

print '------------------------------------------------------------------'
print '{0} - Back Up DB Upload to S3'.format(datetime.now().strftime("%Y-%m-%d"))
def zipdir(path, zip):
    for root, dirs, files in os.walk(path):
        for file in files:
            zip.write(os.path.join(root, file))

if os.listdir(FOLDER):
    with zipfile.ZipFile(ZIP_NAME, 'w') as zipf:
        print '        Zip file {0}'.format(ZIP_NAME)
        zipdir(FOLDER, zipf)
        zipf.close()

if os.path.exists(ZIP_NAME):
    print '        Upload to S3 bucket'
    conn = tinys3.Connection(S3_ACCESS_KEY, S3_SECRET_KEY, tls=True)
    f = open(ZIP_NAME,'rb')
    conn.upload('db_backup_{0}.zip'.format(DAY_WEEK), f, BUCKET_NAME, public=False)

