#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR="/home/ec2-user/app-logs"
LOGS_FOLDER="/var/logs/shell-script"
mkdir -p $LOGS_FOLDER
LOG_FILE=$( echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


echo "Log file created at $LOG_FILE_NAME" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
  echo "Error:: You must have root privileges to run this script" 
  exit 1
else
  echo "You have root privileges"
fi

VALIDATE(){
  if [ $1 -ne 0 ]
  then
    echo -e "$2...$R Failure $N" 
    exit 1
  else
    echo -e "$2 ... $G Success $N" 
  fi
}

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

echo "Files to delete: $FILES_TO_DELETE"

while read -r file
do
  echo "Deleting file: $file"
  rm -rf $file
  VALIDATE $? "Deleting file $file"
done <<< "$FILES_TO_DELETE"
echo "All log files older than 14 days have been deleted."
