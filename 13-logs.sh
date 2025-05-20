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
    echo -e "$2...$R Failure $N" &>>LOG_FILE_NAME
    exit 1
  else
    echo "$2 ... $G Success $N" &>>LOG_FILE_NAME
  fi
}


dnf list installed mysql &>>LOG_FILE_NAME
echo "$?"

if [ $? -ne 0 ]
then
  dnf install mysql -y &>>LOG_FILE_NAME
  VALIDATE $? "MySQL installation" &>>LOG_FILE_NAME
else
  echo -e "$Y MySQL is already installed $N" &>>LOG_FILE_NAME
fi


dnf list installed git &>>LOG_FILE_NAME
echo "$?"

if [ $? -ne 0 ]
then
  dnf install git -y &>>LOG_FILE_NAME
  VALIDATE $? "GIT installation" &>>LOG_FILE_NAME
else
  echo -e "$Y GIT is already installed $N" &>>LOG_FILE_NAME
fi