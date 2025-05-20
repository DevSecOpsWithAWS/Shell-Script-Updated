#!/bin/bash




USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "Error:: You must have root privileges to run this script"
  exit 1
else
  echo "You have root privileges"
  dnf install mysql -y
fi

