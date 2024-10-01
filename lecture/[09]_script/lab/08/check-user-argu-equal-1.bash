#!/bin/bash
if (( $# == 1 ))
  then
    echo "Date and time is: $(date)"
      if who | grep $1 >/dev/null
        then  
          echo "$1 is log in :"
        else
          echo "$1 is not log in"
      fi
  else 
    echo "input 1 parameter only!"
    exit 1
  fi