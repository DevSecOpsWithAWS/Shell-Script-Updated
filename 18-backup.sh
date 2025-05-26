#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14} # Default to 14 days if not provided

if [ $USERID -ne 0 ]
then
  echo "Error:: You must have root privileges to run this script" 
  exit 1
else
  echo "You have root privileges"
fi

LOGS_FOLDER="/var/logs/shell-script"
mkdir -p $LOGS_FOLDER
LOG_FILE=$( echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


#echo "Log file created at $LOG_FILE_NAME" &>>$LOG_FILE_NAME



VALIDATE(){
  if [ $1 -ne 0 ]
  then
    echo -e "$2...$R Failure $N" 
    exit 1
  else
    echo -e "$2 ... $G Success $N" 
  fi
}


USAGE(){
  echo -e "$R USAGE:: $N sh 18-backup.sh <source_directory> <destination_directory> <days(Optional)>"
  exit 1
}

if [ $# -lt 2 ]
then
  USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
  echo -e "$R Source directory $SOURCE_DIR does not exist $N"
  exit 1
fi
if [ ! -d $DESTINATION_DIR ]
then
  echo -e "$R Destination directory $DESTINATION_DIR does not exist $N"
  exit 1
fi

echo -e "Script started executing at $TIMESTAMP"

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ]
then
  echo "FILES TO BACKUP: $FILES"
  ZIP_FILE="$DESTINATION_DIR/app-logs-$TIMESTAMP.zip"
  find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ $ZIP_FILE
  if [ -f "$ZIP_FILE" ]
  then
    echo -e "Successfully created zip file for files older than $DAYS"
    while read -r filepath
    do
      echo "Deleting file: $filepath"
      rm -rf $filepath
      VALIDATE $? "Deleting file $filepath"
    done <<< "$FILES"
  else
    echo -e "$R Failed to create zip file $N"
    exit 1
  fi
else
  echo -e "$Y No files older than $DAYS days found in $SOURCE_DIR $N"
fi

