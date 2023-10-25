#!/bin/bash

source .env;
clear;

function selected() {
	echo -e "\nSelected ${1}: \e[0;33m${2}\e[0m"
}

function chooseType() {
	echo -e "Type of the repository [\e[0;33mWEB\e[0m]"
	printf '> '
	read type
	if [ -z "${type}" ]; then
		type="WEB"
	fi
	type=$(echo $type | tr '[:lower:]' '[:upper:]')
}

function chooseCode() {
	echo -e "\nCode of the repository [\e[0;33m500\e[0m]"
	printf '> '
	read code
	if [ -z "${code}" ]; then
		code="500"
	fi
}

function chooseTeam() {
	echo -e "\nWhat's your team ? [\e[0;33mSTG_11\e[0m]"
	printf '> '
	read team
	if [ -z "${team}" ]; then
		team="STG_11";
	fi
}

function isProject() {
	echo -e "\nIs it a project ? (yes/no) [\e[0;33mno\e[0m]"
	printf '> '
	read project
	if [ "${project}" == "yes" ]; then
		project=1;
	else
		project=0;
	fi
}

chooseType;
chooseCode;
isProject;

if [ ${project} == 1 ]; then
	chooseTeam;
	ROOT="T-${type}-${code}-${team}"
else
	ROOT="T-${type}-${code}_${PROJECT_EXTENSION}"
fi

if ! [ -d "${ROOT}" ]; then
	mkdir $ROOT
	echo -e "\n\e[0;32mSuccess\e[0m: ${ROOT} created."
fi

cd $ROOT

if [ ${project} == 1 ]; then
	repository="T-${type}-${code}-${team}";
	git clone "git@github.com:${PROMOTION_NAME}/${repository}.git" .
	rm -rf .git
	if [ -f ".env.example" ]; then
		echo -e "\n.env.example file found, continue ? (yes/no) [\e[0;33mno\e[0m]"
		printf '> '
		read type
		if ! [ "${type}" == "yes" ]; then
			echo -e "\nPush aborted."
			exit; 
		fi
	fi
else
	echo -e "";
	for ((i=1; i<=10; i++))
	do
		if [ $i -lt 10 ]; then
			fday="0$i"
		else
			fday="$i"
		fi
		repository="T-${type}-${code}-day${fday}-STG_${STUDENT_NAME}"
		if [ -d "${repository}" ]; then
			echo -e "\e[0;31mError\e[0m: ${repository} already exists, skip."
		else
			git clone "git@github.com:EpitechMscProPromo2026/${repository}.git" > /dev/null 2>&1
			if [ $? -ne 0 ]; then
				echo -e "\e[0;31mError\e[0m: ${repository} doesn't exist on remote, skip.";
			else
				rm -rf $repository/.git $repository/*.pdf
				if [ "$(ls -A ${repository})" ]; then
					git add $repository > /dev/null 2>&1
					git commit -m "Push ${repository}." > /dev/null 2>&1
					git push > /dev/null 2>&1
					echo -e "\e[0;32mSuccess\e[0m: ${repository} pushed.";
				else
					rm -rf $repository
					echo -e "\e[0;31mError\e[0m: ${repository} is empty, deleted.";
				fi
			fi
		fi
	done
fi
