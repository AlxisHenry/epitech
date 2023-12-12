#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "Usage: ./script3.sh <file> [options]"
    exit 1
fi

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

color=false;
random=false;
for arg in $@; do
    if [ $arg == "-c" ] || [ $arg == "--color" ]; then
        color=true;
    fi
    if [ $arg == "-r" ] || [ $arg == "--random" ]; then
        random=true;
    fi
done

while read line; do
    hasKeyword=false;
    currentLine="${line}";
    line="";
    
    for word in $currentLine;
    do
        if [ $word == "epitech" ]; then
            hasKeyword=true;
            if [ $color == true ]; then
                line+="\033[1;36mepitech\033[0m";
            else
                line+="epitech";
            fi
        else
            if [ $random == true ]; then
                letter=$(openssl rand -base64 5 | tr -dc 'a-zA-Z' | head -c 1 | tr '[:lower:]' '[:upper:]');
                replacedWord=$(printf "%0.s$letter" $(seq 1 ${#word}));
                line+=" $replacedWord ";
            else 
                line+=" $word ";
            fi
        fi
    done
    
    if [ $hasKeyword == true ]; then
        line=$(echo $line | sed 's/  / /g');
        keywordSentences+=("$line");
        echo "$line" >> $keywordFile;
    fi
done <$file;

echo -e "\033[1;36mT-NSA-500>\033[0m There are \033[1;36m${linesCount}\033[0m lines in the file."
echo -e "The word epitech appears \033[1;36m${keywordsCount}\033[0m times."
for keywordSentence in "${keywordSentences[@]}"; do
        echo -e "$keywordSentence";
done
