#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt 0 ]
then
    echo "$NUMBER is a Positive Number"
elif [ $NUMBER -lt 0 ]
then
    echo "$NUMBER is a Negative Number"
else
    echo "$NUMBER is Zero"
fi