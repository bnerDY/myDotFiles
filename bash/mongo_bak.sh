#!/bin/sh
DUMP=mongodump
OUT_DIR=/home/rom/spider-mon-db/backup/tmp
TAR_DIR=/home/rom/spider-mon-db/backup
DATE=`date +%Y_%m_%d_%H_%M_%S`
DAYS=14
TAR_BAK="mongod_bak_$DATE.tar.gz"
cd $OUT_DIR
rm -rf $OUT_DIR/*
mkdir -p $OUT_DIR/$DATE
$DUMP --host sjnitapp18 --port 9051 --out $OUT_DIR/$DATE
tar -zcvf $TAR_DIR/$TAR_BAK $OUT_DIR/$DATE
find $TAR_DIR/ -mtime +$DAYS -delete


# crontab  0 2 * * * bash /home/rom/spider-mon-db/backup/spider-application-bak.sh >> /home/rom/spider-mon-db/backup/backup-daily.log 2>&1