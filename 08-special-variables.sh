#!/bin/bash


echo "first argument : $1"
echo "$2 --> second argument"
echo "$3 --> third argument"
echo "$0 --> Script Name"
echo "$@ --> All arguments passed"
echo "$# --> number of variables passed"
echo "$PWD --> present working directory"
echo "$HOME --> home directoy of current user"
echo "$USER --> which user running the script"
echo "$$ --> Process ID of current script"
echo "$? --> exit status of last command"
sleep 60 &
echo "$! --> process id of last background command"