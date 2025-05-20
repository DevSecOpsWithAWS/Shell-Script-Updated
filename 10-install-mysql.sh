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

dnf list installed mysql
echo "$?"

if [ $? -ne 0 ]
then
  dnf install mysql -y
  if [ $? -ne 0]
  then
    echo "installing MySQL...Failure"
    exit 1
  else
    echo "MySQL installation completed successfully"
  fi
else
  echo "MySQL is already installed"
fi
