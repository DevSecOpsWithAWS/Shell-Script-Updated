#!/bin/bash




USERID=$(id -u)
if [ $USERID -ne 0 ]
  echo "Error:: You must have root privileges to run this script"
  exit 1
fi

dnf install mysql -y