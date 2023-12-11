#!/bin/bash

if [ "$#" -lt 2 ]; then

        if [ $# -eq 0 ]; then
            exit 0
        fi

        if [ "$1" == "ACCEPTED" ]; then
                attempts=$(grep 'Accepted' /var/log/auth.log | awk '{print "ACCEPTED;" $(NF-3) ";" $(NF-5)}' FS='[ :]+' OFS=';')
        elif [ "$1" == "FAILED" ]; then
                attempts=$(grep 'Failed' /var/log/auth.log | awk '{print "FAILED;" $(NF-3) ";" $(NF-5)}' FS='[ :]+' OFS=';');
        fi

        for line in ${attempts}; do
                echo "${line}"
        done
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

attempt=$(ssh -o ConnectTimeout=5 "$username@$hostname" "exit" 2>&1)

if [ $? -eq 0 ]; then
        echo "ACCEPTED;$hostname;$username";
else
        echo "FAILED;$hostname;$username";
fi
