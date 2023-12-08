#!/bin/bash

file=$1;

if [ -z "$file" ]; then
    echo "No file name provided."
    exit 1
fi

if [ ! -f $file ];
then
        echo "File doesn't exist.";
        exit 1;
fi

keywordsCount=0;
keywordSentences=();
linesCount=$(wc -l $file | cut -d " " -f 1);
keywordFile="/tmp/epitech2.txt";

if [ ! -f $keywordFile ];
then
        touch /tmp/epitech2.txt;
fi

while read line; do
   for word in $line;
   do
        if [ $word == "epitech" ];
        then
                keywordsCount=$((++keywordsCount));
                keywordSentences+=("$line");
                echo $line >> $keywordFile;
        fi
   done
done <$file;

echo -e "\033[1;36mT-NSA-500>\033[0m There are $linesCount lines in the file."
echo "The word epitech appears $keywordsCount times."
for keywordSentence in "${keywordSentences[@]}"; do
        echo "$keywordSentence";
done