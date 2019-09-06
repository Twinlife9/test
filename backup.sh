#!/bin/bash

Host=127.0.0.1
BDir=~/backup/mysql

Dump="/usr/bin/mysqldump -B -uroot --skip-extended-insert --force"
MySQL=/usr/bin/mysql

Today=$(date "+%a")

# Get a list of all databases
Databases=$(echo "SHOW DATABASES" | $MySQL -h $Host -uroot)


for db in $Databases; do
  date=`date`
  file="$BDir/$Host-$db-$Today.sql.gz"
  echo "Backing up '$db' from '$Host' on '$date' to: "
  echo "   $file"
  $Dump -h $Host $db | gzip > $file
done
