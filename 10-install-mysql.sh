#!/bin/bash




USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "Error:: You must have root privileges to run this script"
  exit 1
else
  echo "You have root privileges"
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


dnf list installed git
echo "$?"

if [ $? -ne 0 ]
then
  dnf install git -y
  if [ $? -ne 0]
  then
    echo "Installing GIT...Failure"
    exit 1
  else
    echo "GIT installation completed successfully"
  fi
else
  echo "GIT is already installed"
fi