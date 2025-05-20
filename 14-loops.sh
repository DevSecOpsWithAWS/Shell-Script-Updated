#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
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
    echo "$2 ... $G Success $N" 
  fi
}

for package in $@
do
    dnf list installed $package &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
        dnf install $package -y &>>$LOG_FILE_NAME
        VALIDATE $? "$package installation"
    else
        echo -e "$Y $package is already installed $N"
    fi
done