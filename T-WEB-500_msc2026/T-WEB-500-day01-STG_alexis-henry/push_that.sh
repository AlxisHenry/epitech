#!/bin/bash
git add .
message="$@"
if [ -z "$message" ];
then
	message="$(date)"
fi
git commit -m "$message"
git push origin master
