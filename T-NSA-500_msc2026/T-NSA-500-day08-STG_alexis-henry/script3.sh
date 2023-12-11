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

keywordSentences=();
keywordsCount=$(cat $file | grep -c "epitech");
linesCount=$(wc -l $file | cut -d " " -f 1);
keywordFile="/tmp/epitech2.txt";

if [ ! -f $keywordFile ];
then
        touch /tmp/epitech2.txt;
fi

while read line; do
   for word in $line;
   do
        if [ $word == "epitech" ]; then
            if [[ $# -eq 2 ]]; then
                old="${line}";
                line="";
                for w in $old; do
                    if [ "$w" != "epitech" ]; then
                        random_letter=$(openssl rand -base64 1 | tr -dc 'A-Z' | head -c1)
                        repeated_letter=$(printf "%0.s$random_letter" $(seq 1 ${#w}))
                        line+="$repeated_letter "
                    else
                        line+="\033[1;36mepitech \033[0m"
                    fi
                done
            fi
            keywordSentences+=("$line")
            echo "$new_line" >> "$keywordFile"
        fi
   done
done <$file;

echo -e "\033[1;36mT-NSA-500>\033[0m There are \033[1;36m${linesCount}\033[0m lines in the file."
echo -e "The word epitech appears \033[1;36m${keywordsCount}\033[0m times."
for keywordSentence in "${keywordSentences[@]}"; do
        echo -e "$keywordSentence";
done