#!/bin/bash


NUMBER1=$1
NUMBER2=$2

TIMESTAMP=$(date)

echo "Script started executing at $TIMESTAMP"
echo "The first number is $NUMBER1"
echo "The second number is $NUMBER2"
echo "SUM of $NUMBER1 and $NUMBER2 is $(($NUMBER1+$NUMBER2))"

