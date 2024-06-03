source .env;

function makeTeamsImageUrl() {
        folders="$(ls -d T-*/)"
        teams=()

        for folder in $folders; do
                if [[ ! $folder =~ $PROJECT_EXTENSION ]]; then
                        team=$(echo $folder | cut -d'-' -f4- | cut -d'/' -f1)
                        teams+=("$team")
                fi
        done

        declare -A teamCount
        for team in ${teams[@]}; do
                teamCount[$team]=$((${teamCount[$team]} + 1))
        done

        url="$TEAMS_API_URL"

        for team in ${!teamCount[@]}; do
                url+="${team}@${teamCount[$team]},"
        done

        url=${url::-1}
        currentLine=$(grep -n "Teams](" README.md | cut -d':' -f1)
        if [[ -n "$currentLine" ]]; then
                sed -i "${currentLine}s|.*|![Teams](${url})|" README.md
                git add README.md
                git commit -m "Update Teams image in README.md"
        else
                echo "No line with 'Teams](' found in README.md"
        fi
}

makeTeamsImageUrl;
