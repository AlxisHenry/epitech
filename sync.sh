#!/bin/bash

echo "Enter the type (PRE, WEB, etc.):"
read type
echo "Enter the repository code (500/501):"
read code

if [ -z "${type}" ]; then
  echo "Type cannot be empty. Exiting..."
  exit 1
fi

if [ -z "${code}" ]; then
	code="500"
fi

root_dir="T-${type}-${code}_msc2026"
if [ ! -d "${root_dir}" ]; then
	echo "Given root directory doesn't exist."
	exit 1
fi
cd $root_dir

for ((i=1; i<=10; i++))
do
  if [ $i -lt 10 ]; then
    fday="0$i"
  else
    fday="$i"
  fi
  repo_name="T-${type}-${code}-day${fday}-STG_alexis-henry"
  # Check if the repository already exists
  if [ -d "${repo_name}" ]; then
    echo "${repo_name} already exists..."
  else
		git clone "git@github.com:EpitechMscProPromo2026/${repo_name}.git"
		rm -rf $repo_name/.git
		if [ "$(find  T-WEB-500_msc2026/T-WEB-500-day10-STG_alexis-henry/ -maxdepth 1 -type f -not -name '.git' | wc -l" -eq 0 ]; then
			rm -rf ${repo_name}
		else
			file="../subjects/T-${type}-${code}_day${fday}.pdf"
			rm -rf "${repo_name}/T-${type}-${code}_day${fday}.pdf"
			cp $file ./$repo_name
			cd ..
			git add ${root_dir}/${repo_name}
			git commit -m "Push ${repo_name}."
			git push
		fi
  fi
done

cd ..
