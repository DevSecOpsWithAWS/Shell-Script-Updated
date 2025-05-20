#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
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


dnf list installed mysql
echo "$?"

if [ $? -ne 0 ]
then
  dnf install mysql -y
  VALIDATE $? "MySQL installation"
else
  echo -e "$Y MySQL is already installed $N"
fi


dnf list installed git
echo "$?"

if [ $? -ne 0 ]
then
  dnf install git -y
  VALIDATE $? "GIT installation"
else
  echo -e "$Y GIT is already installed $N"
fi