#!/bin/bash

USERID=$(id -u)

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
    echo "$2...Failure"
    exit 1
  else
    echo "$2 ...Success"
  fi
}


dnf list installed mysql
echo "$?"

if [ $? -ne 0 ]
then
  dnf install mysql -y
  VALIDATE $? "MySQL installation"
else
  echo "MySQL is already installed"
fi


dnf list installed git
echo "$?"

if [ $? -ne 0 ]
then
  dnf install git -y
  VALIDATE $? "GIT installation"
else
  echo "GIT is already installed"
fi