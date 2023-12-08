#!/bin/bash

if [ "$#" -eq 0 ]; then
        echo "Usage: ./script5.sh <username> <hostname>"
        exit 0;
fi

username=$1;
hostname=$2;

if [ -z $username ];
then
  exit 0;
fi

if [ -z $hostname ];
then
  exit 0;
fi

ssh_check=$(ssh -o ConnectTimeout=5 "$username@$hostname" "exit" 2>&1)

if [ $? -eq 0 ]; then
    echo "ACCEPTED;$hostname;$username";
else
    echo "FAILED;$hostname;$username";
fi