#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/.local/bin:/bin/python"

DESTI="path_to_store_logs"
INSTANCE="instancia"
client=""

if [ -n "$1" ];
then
        LOGFILE="postgresql.log."$1;
        CURDAT=$(date "+%Y-%m-%d")
fi
if [ -n "$2" ];
then
        LOGFILE2="postgresql.log.";
fi

if [ -z "${LOGFILE}" ];
then
  # List avialable logs on AWS
  /bin/python /root/.local/bin/aws rds describe-db-log-files --db-instance-identifier ${INSTANCE};
elif [ -z "${LOGFILE2}" ];
then
  #Downloading the specified log
  /root/.local/bin/aws rds download-db-log-file-portion --db-instance-identifier ${INSTANCE} --starting-token 0 --output text --log-file-name "error/"$LOGFILE > $DESTI$LOGFILE;
 chown custuser: $DESTI$LOGFILE
elif [ -n "${LOGFILE}" ] && [ -n "${LOGFILE2}" ];
then
  #Downloading rank of logs
  mkdir "$DESTI$CURDAT"
  for i in $(/root/.local/bin/aws rds describe-db-log-files --db-instance-identifier ${INSTANCE} --profile ${client} --output text | awk '{print $3}') ; 
  do
        NETEJAT=${i##*.};       # Removing all data except data
        NET=${NETEJAT::-3};     # Removing time and last -

        if [ "$(date -d $NET +"%s")" -ge "$(date -d ${1::-3} +'%s')" ] && [ "$(date -d $NET +"%s")" -le "$(date -d ${2::-3} +'%s')" ];
        then
                /root/.local/bin/aws rds download-db-log-file-portion --db-instance-identifier ${INSTANCE} --starting-token 0 --output text --log-file-name $i > $DESTI$CURDAT"/"$LOGFILE2"-"$NETEJAT;
        fi
        chown custuser: "$DESTI$CURDAT" -R
  done  
fi
