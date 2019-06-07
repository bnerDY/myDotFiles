#!/bin/bash

usage="Usage: dir_diff.sh [days] [dir]"
if [ -z "$1" ] || [ -z "$2" ] ; then
  echo$usage
  exit1
fi
echo $1
echo $2
now=$(date +%s)
hadoop fs -ls $2 | grep "^d" | while read f; do
  dir_date=`echo $f | awk '{print $6}'`
  difference=$(( ( $now - $(date -d "$dir_date" +%s) ) / (24 * 60 * 60 ) ))
  if [ $difference -gt $1 ]; 
  then
    hadoop fs -rm -r -skipTrash  `echo $f| awk '{ print $8 }'`;
    # hadoop fs -ls `echo $f| awk '{ print $8 }'`;
  fi
done
