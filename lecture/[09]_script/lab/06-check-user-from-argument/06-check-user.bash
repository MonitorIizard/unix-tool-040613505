#!/bin/bash
echo "Date and time is:$(date)" >user.log
if who | grep $1 > /dev/null
  then
    echo "$1 is log in" >>user.log
  else
    echo "$1 is not log in" >>user.log
fi