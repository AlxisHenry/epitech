ignored_extensions=("svg" "md" "gitignore" "example" "mp3" "jpg" "txt" "png" "jpeg" "gif" "sh")
folders=$(ls -d T-*/)
file="./technologies.md"
repo_url="https://github.com/AlxisHenry/epitech/tree/master/"

echo "# Technologies used" > $file

echo "**Note**: This file is generated automatically. Do not edit it manually.<br/>" >> $file
echo "**Note**: some extensions are ignored (e.g. .gitignore, .example, .md, .svg, .mp3, .jpg, .txt, .png, .jpeg, .gif, .sh)" >> $file

for folder in $folders; do
    cd "$folder"
    folderName="$(basename "$folder")"

    find_command="find . -type f !"
    
    for ext in "${ignored_extensions[@]}"; do
        find_command+=" -name '*.$ext'"
        if [ "$ext" != "${ignored_extensions[-1]}" ]; then
            find_command+=" !"
        fi
    done
    
    find_command+=" -name '*.*'"
    total_files=$(eval $find_command | wc -l)
    extensions=$(eval $find_command | sed -n 's/.*\.\(.*\)$/\1/p' | sort | uniq -c | awk '$1 > 1 {printf "| %s | %d | %.2f%% |\n", $2, $1, ($1 / '"$total_files"' * 100)}')

    cd ..

    echo "" >> $file;
    echo "## $folderName" >> $file;
    echo "You can be redirected to the folder by clicking [here]($repo_url/$folderName)." >> $file;
    echo "| Extension | Occurrences | Percentage |" >> $file;
    echo "| --------- | ----------- | ---------- |" >> $file;
    echo -e "$extensions" >> $file;

done

